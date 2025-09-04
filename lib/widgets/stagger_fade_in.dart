import 'package:flutter/material.dart';

/// Liste/ızgara öğelerine girişte sırayla fade + aşağıdan kayma animasyonu.
class StaggerFadeIn extends StatefulWidget {
  final int index;
  final Widget child;

  /// Her öğe için animasyon süresi
  final Duration duration;

  /// Giriş gecikmesi için temel değer (null ise 60ms * index)
  final Duration? baseDelay;

  /// Aşağıdan kayma miktarı; 0.0 - 1.0 arası (piksel değil, slayt fraksiyonu)
  final double slideFraction;

  const StaggerFadeIn({
    super.key,
    required this.index,
    required this.child,
    this.duration = const Duration(milliseconds: 380),
    this.baseDelay,
    this.slideFraction = 0.06,
  });

  @override
  State<StaggerFadeIn> createState() => _StaggerFadeInState();
}

class _StaggerFadeInState extends State<StaggerFadeIn> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    final delay = widget.baseDelay ?? Duration(milliseconds: 60 * widget.index);
    Future.delayed(delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: widget.duration,
      curve: Curves.easeOut,
      offset: _visible ? Offset.zero : Offset(0, widget.slideFraction),
      child: AnimatedOpacity(
        duration: widget.duration,
        curve: Curves.easeOut,
        opacity: _visible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}
