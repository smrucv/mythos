import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/chiguire_grove_splash.dart';
import 'mythos_theme.dart';

/// Animación original del estudio -> MYTHOS -> biblioteca, sin marca nativa previa.
class StartupSequence extends StatefulWidget {
  const StartupSequence({super.key, required this.child, this.enabled = true});
  final Widget child;
  final bool enabled;

  @override
  State<StartupSequence> createState() => _StartupSequenceState();
}

enum _StartupStage { grove, toMythos, mythos, toLibrary, ready }

class _StartupSequenceState extends State<StartupSequence>
    with SingleTickerProviderStateMixin {
  late _StartupStage _stage;
  late final AnimationController _fade;
  late final CurvedAnimation _opacity;
  Timer? _hold;
  bool _reducedMotion = false;

  @override
  void initState() {
    super.initState();
    _stage = widget.enabled ? _StartupStage.grove : _StartupStage.ready;
    _fade = AnimationController(vsync: this)..addStatusListener(_onFadeStatus);
    _opacity = CurvedAnimation(parent: _fade, curve: Curves.easeInOut);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final query = MediaQuery.maybeOf(context);
    _reducedMotion = (query?.disableAnimations ?? false) ||
        (query?.accessibleNavigation ?? false);
    _fade.duration = Duration(milliseconds: _reducedMotion ? 0 : 600);
  }

  void _showMythos() {
    if (!mounted || _stage != _StartupStage.grove) return;
    setState(() => _stage = _StartupStage.toMythos);
    _fade.forward(from: 0);
  }

  void _onFadeStatus(AnimationStatus status) {
    if (!mounted || status != AnimationStatus.completed) return;
    if (_stage == _StartupStage.toMythos) {
      setState(() => _stage = _StartupStage.mythos);
      // Contar la permanencia solamente después del fundido de entrada.
      _hold = Timer(const Duration(milliseconds: 1500), _showLibrary);
    } else if (_stage == _StartupStage.toLibrary) {
      setState(() => _stage = _StartupStage.ready);
    }
  }

  void _showLibrary() {
    if (!mounted || _stage != _StartupStage.mythos) return;
    setState(() => _stage = _StartupStage.toLibrary);
    _fade.forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant StartupSequence oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled && !widget.enabled) {
      _hold?.cancel();
      _fade.stop();
      _stage = _StartupStage.ready;
    }
  }

  @override
  void dispose() {
    _hold?.cancel();
    _fade.removeStatusListener(_onFadeStatus);
    _opacity.dispose();
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ready = _stage == _StartupStage.ready;
    return Stack(
      fit: StackFit.expand,
      children: [
        ExcludeSemantics(
          excluding: !ready,
          child: IgnorePointer(ignoring: !ready, child: widget.child),
        ),
        if (_stage == _StartupStage.grove || _stage == _StartupStage.toMythos)
          ExcludeSemantics(
            excluding: _stage != _StartupStage.grove,
            child: ColoredBox(
              key: const ValueKey('chiguire-grove-stage'),
              color: const Color(0xFFF5F2EA),
              child: ChiguireGroveSplashScreen(onFinished: _showMythos),
            ),
          ),
        if (_stage != _StartupStage.grove && !ready)
          FadeTransition(
            // Una capa opaca permanece debajo durante todo el fundido.
            // Así la biblioteca nunca se filtra entre estudio y MYTHOS.
            opacity: _stage == _StartupStage.toMythos
                ? _opacity
                : _stage == _StartupStage.toLibrary
                    ? ReverseAnimation(_opacity)
                    : const AlwaysStoppedAnimation(1),
            child: const MythosTitleSplash(
              key: ValueKey('mythos-title-stage'),
            ),
          ),
        if (ready)
          const IgnorePointer(
            child: SizedBox.expand(key: ValueKey('startup-ready')),
          ),
      ],
    );
  }
}

/// Presentación minimalista: fondo #10101A, libro y texto MYTHOS.
class MythosTitleSplash extends StatelessWidget {
  const MythosTitleSplash({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: MythosPalette.background,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox.square(
                dimension: 72,
                child: CustomPaint(painter: _BookOpenPainter()),
              ),
              const SizedBox(height: 18),
              const Text(
                'MYTHOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MythosPalette.gold,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      );
}

/// Libro abierto: trazado de contorno sencillo, sin estrellas ni adornos.
class _BookOpenPainter extends CustomPainter {
  const _BookOpenPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 24, size.height / 24);
    final paint = Paint()
      ..color = MythosPalette.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final left = Path()
      ..moveTo(12, 7)
      ..cubicTo(11, 4.8, 9, 3, 7, 3)
      ..lineTo(5, 3)
      ..quadraticBezierTo(3, 3, 3, 5)
      ..lineTo(3, 18)
      ..quadraticBezierTo(3, 19, 4, 19)
      ..lineTo(8, 19)
      ..quadraticBezierTo(12, 19, 12, 22);
    final right = Path()
      ..moveTo(12, 7)
      ..cubicTo(13, 4.8, 15, 3, 17, 3)
      ..lineTo(19, 3)
      ..quadraticBezierTo(21, 3, 21, 5)
      ..lineTo(21, 18)
      ..quadraticBezierTo(21, 19, 20, 19)
      ..lineTo(16, 19)
      ..quadraticBezierTo(12, 19, 12, 22);
    canvas.drawPath(left, paint);
    canvas.drawPath(right, paint);
    canvas.drawLine(const Offset(12, 7), const Offset(12, 21), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
