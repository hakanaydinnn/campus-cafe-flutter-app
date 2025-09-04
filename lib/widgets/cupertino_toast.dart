import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CupertinoToast {
  static Future<void> show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Duration duration = const Duration(milliseconds: 1100),
  }) async {
    // iOS benzeri hafif titreşim
    HapticFeedback.lightImpact();

    final overlay = Overlay.maybeOf(context);
    if (overlay == null) {
      return;
    }

    final entry = OverlayEntry(
      builder: (ctx) {
        final brightness = Theme.of(ctx).brightness;
        final bool isDark = brightness == Brightness.dark;

        // iOS benzeri cam efektli (blur) pill
        return IgnorePointer(
          ignoring: true,
          child: Stack(
            children: [
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: _ToastPill(
                  message: message,
                  icon: icon,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(entry);
    await Future.delayed(duration);
    entry.remove();
  }
}

class _ToastPill extends StatefulWidget {
  final String message;
  final IconData? icon;
  final bool isDark;

  const _ToastPill({
    required this.message,
    this.icon,
    required this.isDark,
  });

  @override
  State<_ToastPill> createState() => _ToastPillState();
}

class _ToastPillState extends State<_ToastPill>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 180))
    ..forward();
  late final Animation<double> _fade =
      CurvedAnimation(parent: _c, curve: Curves.easeOut);
  late final Animation<Offset> _slide =
      Tween(begin: const Offset(0, 0.05), end: Offset.zero).animate(_fade);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = widget.isDark
        ? Colors.white.withOpacity(0.12)
        : Colors.black.withOpacity(0.08);

    final fg = widget.isDark ? Colors.white : Colors.black87;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: widget.isDark
                      ? Colors.white.withOpacity(0.12)
                      : Colors.black.withOpacity(0.06),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 18, color: fg),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      widget.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.2,
                        color: fg,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        decoration: TextDecoration.none,
                        decorationColor: Colors.transparent,
                        decorationThickness: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
