import 'dart:async';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _splashDuration = Duration(milliseconds: 5700);
const _reducedMotionDuration = Duration(milliseconds: 1500);
// El splash nativo de Android debe desaparecer antes de iniciar la línea temporal.
const _firstFrameSettle = Duration(milliseconds: 300);
const _logoAsset =
    'assets/branding/chiguire_grove_isotipo_original_trazado.svg';

/// A responsive, self-contained studio splash.
///
/// Sound paths are relative to `assets/` and are only loaded when
/// [enableSound] is true. The splash owns and disposes its audio players.
class ChiguireGroveSplashScreen extends StatefulWidget {
  const ChiguireGroveSplashScreen({
    required this.onFinished,
    this.enableSound = false,
    this.seedLandingSoundAsset,
    this.growthSoundAsset,
    this.forestAmbienceAsset,
    super.key,
  });

  final VoidCallback onFinished;
  final bool enableSound;
  final String? seedLandingSoundAsset;
  final String? growthSoundAsset;
  final String? forestAmbienceAsset;

  @override
  State<ChiguireGroveSplashScreen> createState() =>
      _ChiguireGroveSplashScreenState();
}

class _ChiguireGroveSplashScreenState extends State<ChiguireGroveSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _timelineProgress;
  AudioPlayer? _landingPlayer;
  AudioPlayer? _growthPlayer;
  AudioPlayer? _ambiencePlayer;
  bool _started = false;
  bool _finished = false;
  bool _landingPlayed = false;
  bool _growthPlayed = false;
  bool _reducedMotion = false;
  Timer? _firstFrameTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _splashDuration,
    )
      ..addListener(_handleTimeline)
      ..addStatusListener(_handleStatus);
    _timelineProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.maybeOf(context);
    final reducedMotion = (mediaQuery?.disableAnimations ?? false) ||
        (mediaQuery?.accessibleNavigation ?? false);
    if (_started && reducedMotion == _reducedMotion) {
      return;
    }

    _reducedMotion = reducedMotion;
    _controller.duration =
        reducedMotion ? _reducedMotionDuration : _splashDuration;
    if (!_started) {
      _started = true;
      // Esperar al primer frame antes de consumir los 5,7 s de animación.
      // Durante el montaje inicial Android puede seguir mostrando su splash
      // nativo o la superficie Flutter todavía puede medir 0x0.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _firstFrameTimer = Timer(_firstFrameSettle, () {
          if (!mounted || _finished) return;
          assert(() {
            debugPrint('MYTHOS_STARTUP: Chiguire Grove inicia; '
                'movimiento_reducido=$_reducedMotion');
            return true;
          }());
          if (widget.enableSound && !_reducedMotion) {
            _startAudio();
          }
          _controller.forward(from: 0);
        });
      });
    }
  }

  void _handleTimeline() {
    if (_reducedMotion || !widget.enableSound) {
      return;
    }
    final elapsedSeconds =
        _controller.value * _splashDuration.inMilliseconds / 1000;
    if (!_growthPlayed && elapsedSeconds >= 1.2) {
      _growthPlayed = true;
      _playAsset(_growthPlayer, widget.growthSoundAsset);
    }
    if (!_landingPlayed && elapsedSeconds >= 1.3) {
      _landingPlayed = true;
      _playAsset(_landingPlayer, widget.seedLandingSoundAsset);
    }
  }

  void _handleStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || _finished) {
      return;
    }
    _finished = true;
    assert(() {
      debugPrint('MYTHOS_STARTUP: Chiguire Grove finaliza');
      return true;
    }());
    widget.onFinished();
  }

  Future<void> _startAudio() async {
    if (widget.seedLandingSoundAsset != null) {
      _landingPlayer = AudioPlayer();
    }
    if (widget.growthSoundAsset != null) {
      _growthPlayer = AudioPlayer();
    }
    if (widget.forestAmbienceAsset != null) {
      final player = AudioPlayer();
      _ambiencePlayer = player;
      try {
        await player.setReleaseMode(ReleaseMode.loop);
        await player.play(
          AssetSource(widget.forestAmbienceAsset!),
          volume: 0.08,
        );
      } catch (_) {
        // Audio must never prevent the splash from completing.
      }
    }
  }

  void _playAsset(AudioPlayer? player, String? asset) {
    if (player == null || asset == null) {
      return;
    }
    unawaited(_play(player, asset));
  }

  Future<void> _play(AudioPlayer player, String asset) async {
    try {
      await player.play(AssetSource(asset), volume: 0.18);
    } catch (_) {
      // Audio must never prevent the splash from completing.
    }
  }

  @override
  void dispose() {
    _firstFrameTimer?.cancel();
    _controller
      ..removeListener(_handleTimeline)
      ..removeStatusListener(_handleStatus)
      ..dispose();
    unawaited(_landingPlayer?.dispose());
    unawaited(_growthPlayer?.dispose());
    unawaited(_ambiencePlayer?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _timelineProgress,
      builder: (context, child) {
        final timeline = _SplashTimeline(
          progress: _timelineProgress.value,
          reducedMotion: _reducedMotion,
        );
        return ColoredBox(
          color: Color.fromRGBO(
            245,
            242,
            234,
            timeline.backgroundOpacity,
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _SplashComposition(
                  constraints: constraints,
                  timeline: timeline,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _SplashComposition extends StatelessWidget {
  const _SplashComposition({
    required this.constraints,
    required this.timeline,
  });

  final BoxConstraints constraints;
  final _SplashTimeline timeline;

  @override
  Widget build(BuildContext context) {
    final shortestSide = math.min(
      constraints.maxWidth,
      constraints.maxHeight,
    );
    final groupWidth = math.min(
      420.0,
      math.max(190.0, constraints.maxWidth * 0.62),
    );
    final logoHeight = math.min(
      groupWidth * 0.70,
      constraints.maxHeight * 0.55,
    );
    final titleSize = (shortestSide * 0.052).clamp(19.0, 31.0);
    final taglineSize = (shortestSide * 0.036).clamp(15.5, 21.5);
    final titleGap = (shortestSide * 0.022).clamp(7.0, 15.0);
    final taglineGap = (shortestSide * 0.014).clamp(6.0, 11.0);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: groupWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: groupWidth,
              height: logoHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: timeline.plantOpacity,
                    child: _SeedAndSprout(
                      seedFall: timeline.seedFall,
                      growth: timeline.growth,
                      retraction: timeline.retraction,
                    ),
                  ),
                  Opacity(
                    opacity: timeline.logoOpacity,
                    child: Transform.scale(
                      scale: timeline.logoScale,
                      child: SvgPicture.asset(
                        _logoAsset,
                        fit: BoxFit.contain,
                        semanticsLabel: 'Chigüire Grove isotype',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: titleGap),
            Opacity(
              opacity: timeline.titleOpacity,
              child: Text(
                'CHIGÜIRE GROVE',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  inherit: false,
                  color: const Color(0xFF242424),
                  decoration: TextDecoration.none,
                  fontFamily: 'Sora',
                  fontSize: titleSize,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.35,
                  height: 1.1,
                ),
              ),
            ),
            SizedBox(height: taglineGap),
            Opacity(
              opacity: timeline.taglineOpacity,
              child: Text(
                'The Chigüire Way',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  inherit: false,
                  color: const Color(0xFF242424),
                  decoration: TextDecoration.none,
                  fontFamily: 'Sora',
                  fontSize: taglineSize,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeedAndSprout extends StatelessWidget {
  const _SeedAndSprout({
    required this.seedFall,
    required this.growth,
    required this.retraction,
  });

  final double seedFall;
  final double growth;
  final double retraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, constraints.maxHeight);
        final canvasSize = math.min(size * 0.72, 150.0);
        final seedTravel = canvasSize * 0.37;
        return SizedBox.square(
          dimension: canvasSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size.square(canvasSize),
                painter: _SproutPainter(
                  growth: growth,
                  retraction: retraction,
                ),
              ),
              Transform.translate(
                offset: Offset(0, -seedTravel + (seedTravel * seedFall)),
                child: Transform.rotate(
                  angle: (1 - seedFall) * -0.16,
                  child: Container(
                    width: canvasSize * 0.105,
                    height: canvasSize * 0.074,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC79A4B),
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(canvasSize, canvasSize * 0.72),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SproutPainter extends CustomPainter {
  const _SproutPainter({
    required this.growth,
    required this.retraction,
  });

  final double growth;
  final double retraction;

  @override
  void paint(Canvas canvas, Size size) {
    final visibleGrowth = growth * (1 - (retraction * 0.72));
    if (visibleGrowth <= 0) {
      return;
    }

    final base = Offset(size.width * 0.5, size.height * 0.53);
    final tip = Offset(
      size.width * (0.5 + (0.025 * visibleGrowth)),
      size.height * (0.53 - (0.34 * visibleGrowth)),
    );
    final stem = Path()
      ..moveTo(base.dx, base.dy)
      ..quadraticBezierTo(
        size.width * (0.46 - (0.02 * visibleGrowth)),
        size.height * 0.36,
        tip.dx,
        tip.dy,
      );
    canvas.drawPath(
      stem,
      Paint()
        ..color = const Color(0xFF3F5F45)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = math.max(2.0, size.width * 0.025),
    );

    _drawLeaf(
      canvas,
      center: Offset(size.width * 0.47, size.height * 0.36),
      progress: _interval(visibleGrowth, 0.42, 0.82),
      direction: -1,
      color: const Color(0xFF7F9B7A),
      size: size,
    );
    _drawLeaf(
      canvas,
      center: Offset(size.width * 0.53, size.height * 0.30),
      progress: _interval(visibleGrowth, 0.58, 1),
      direction: 1,
      color: const Color(0xFF3F5F45),
      size: size,
    );
  }

  void _drawLeaf(
    Canvas canvas, {
    required Offset center,
    required double progress,
    required double direction,
    required Color color,
    required Size size,
  }) {
    if (progress <= 0) {
      return;
    }
    final width = size.width * 0.21 * progress;
    final height = size.height * 0.09 * progress;
    final leaf = Path()
      ..moveTo(center.dx, center.dy)
      ..quadraticBezierTo(
        center.dx + (direction * width * 0.54),
        center.dy - height,
        center.dx + (direction * width),
        center.dy - (height * 0.18),
      )
      ..quadraticBezierTo(
        center.dx + (direction * width * 0.52),
        center.dy + (height * 0.35),
        center.dx,
        center.dy,
      )
      ..close();
    canvas.drawPath(leaf, Paint()..color = color);
  }

  double _interval(double value, double begin, double end) {
    return ((value - begin) / (end - begin)).clamp(0.0, 1.0);
  }

  @override
  bool shouldRepaint(covariant _SproutPainter oldDelegate) {
    return oldDelegate.growth != growth || oldDelegate.retraction != retraction;
  }
}

class _SplashTimeline {
  const _SplashTimeline({
    required this.progress,
    required this.reducedMotion,
  });

  final double progress;
  final bool reducedMotion;

  double get backgroundOpacity =>
      reducedMotion ? 1.0 : _ease(0, 0.140);
  double get seedFall => _easeOut(0.088, 0.228);
  double get growth => _ease(0.211, 0.404);
  double get retraction => _ease(0.386, 0.588);
  double get plantOpacity =>
      reducedMotion ? 0 : _ease(0.088, 0.123) * (1 - _ease(0.386, 0.579));
  double get logoOpacity =>
      reducedMotion ? 1.0 : _ease(0.377, 0.570);
  double get logoScale {
    if (reducedMotion) {
      return 1;
    }
    if (progress < 0.554) {
      return 0.98;
    }
    if (progress < 0.575) {
      return _lerpWithCurve(0.98, 1.01, 0.554, 0.575);
    }
    if (progress < 0.596) {
      return _lerpWithCurve(1.01, 1, 0.575, 0.596);
    }
    return 1;
  }

  double get titleOpacity =>
      reducedMotion ? 1.0 : _ease(0.579, 0.737);
  double get taglineOpacity =>
      reducedMotion ? 1.0 : _ease(0.702, 0.825);

  double _ease(double begin, double end) {
    final t = ((progress - begin) / (end - begin)).clamp(0.0, 1.0);
    return Curves.easeInOut.transform(t);
  }

  double _easeOut(double begin, double end) {
    final t = ((progress - begin) / (end - begin)).clamp(0.0, 1.0);
    return Curves.easeOutCubic.transform(t);
  }

  double _lerpWithCurve(
    double beginValue,
    double endValue,
    double begin,
    double end,
  ) {
    final t = ((progress - begin) / (end - begin)).clamp(0.0, 1.0);
    final curvedT = Curves.easeInOutSine.transform(t);
    return beginValue + ((endValue - beginValue) * curvedT);
  }
}
