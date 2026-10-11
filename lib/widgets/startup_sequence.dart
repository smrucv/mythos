import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/chiguire_grove_splash.dart';
import 'mythos_theme.dart';

/// Orden de arranque: splash nativo (Android) -> Chigüire Grove -> Mythos -> biblioteca.
/// Las pantallas nativas de Android se configuran en scripts/aplicar_branding_android.ps1.
class StartupSequence extends StatefulWidget {
  const StartupSequence({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  State<StartupSequence> createState() => _StartupSequenceState();
}

enum _StartupStage { grove, mythos, ready }

class _StartupSequenceState extends State<StartupSequence> {
  late _StartupStage _stage;

  @override
  void initState() {
    super.initState();
    _stage = widget.enabled ? _StartupStage.grove : _StartupStage.ready;
  }

  void _showMythos() {
    if (mounted && _stage == _StartupStage.grove) {
      assert(() {
        debugPrint('MYTHOS_STARTUP: transicion Chiguire -> MYTHOS');
        return true;
      }());
      setState(() => _stage = _StartupStage.mythos);
    }
  }

  void _showLibrary() {
    if (mounted && _stage == _StartupStage.mythos) {
      assert(() {
        debugPrint('MYTHOS_STARTUP: transicion MYTHOS -> Biblioteca');
        return true;
      }());
      setState(() => _stage = _StartupStage.ready);
    }
  }

  @override
  void didUpdateWidget(covariant StartupSequence oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si se desactiva para pruebas, no reproducir pantallas de arranque.
    if (oldWidget.enabled && !widget.enabled) {
      _stage = _StartupStage.ready;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget foreground = switch (_stage) {
      _StartupStage.grove => ColoredBox(
          key: const ValueKey('chiguire-grove-stage'),
          color: const Color(0xFFF5F2EA),
          child: ChiguireGroveSplashScreen(onFinished: _showMythos),
        ),
      _StartupStage.mythos => MythosTitleSplash(
          key: const ValueKey('mythos-title-stage'),
          onFinished: _showLibrary,
        ),
      _StartupStage.ready => const SizedBox.expand(
          key: ValueKey('startup-ready'),
        ),
    };

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            ignoring: _stage == _StartupStage.ready,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: foreground,
            ),
          ),
        ),
      ],
    );
  }
}

/// Presentación minimalista aprobada: fondo #10101A, libro y texto MYTHOS.
/// Implementada como widgets/pintura vectorial Flutter, sin imagen rasterizada.
class MythosTitleSplash extends StatefulWidget {
  const MythosTitleSplash({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<MythosTitleSplash> createState() => _MythosTitleSplashState();
}

class _MythosTitleSplashState extends State<MythosTitleSplash> {
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer?.cancel();
    final query = MediaQuery.maybeOf(context);
    final reducedMotion = (query?.disableAnimations ?? false) ||
        (query?.accessibleNavigation ?? false);
    _timer = Timer(
      reducedMotion
          ? const Duration(milliseconds: 650)
          : const Duration(milliseconds: 1500),
      widget.onFinished,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
