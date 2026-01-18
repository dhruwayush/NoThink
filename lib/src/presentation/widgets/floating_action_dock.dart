import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import 'glass_container.dart';

class FloatingActionDock extends StatelessWidget {
  final VoidCallback onAddDecision;
  final VoidCallback onAddMemory;

  const FloatingActionDock({
    super.key,
    required this.onAddDecision,
    required this.onAddMemory,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassContainer(
        borderRadius: BorderRadius.circular(32),
        color: Colors.black,
        opacity: 0.6,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        padding: const EdgeInsets.all(6), // Slightly tighter padding
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DockButton(
              icon: Icons.add_circle_outline, // Changed to outline for cleaner look
              label: "Decision",
              onTap: onAddDecision,
              color: AppTheme.primary,
            ),
            
            // Vertical Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(width: 1, height: 20, color: Colors.white12),
            ),
            
            _DockButton(
              icon: Icons.lightbulb_outline,
              label: "Memory",
              onTap: onAddMemory,
              color: Colors.amberAccent,
            ),
          ],
        ),
      ).animate().slideY(begin: 1, end: 0, curve: Curves.easeOutBack, duration: 600.ms).fadeIn(),
    );
  }
}

class _DockButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _DockButton({required this.icon, required this.label, required this.onTap, required this.color});

  @override
  State<_DockButton> createState() => _DockButtonState();
}

class _DockButtonState extends State<_DockButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.08), // Even more subtle
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: widget.color, size: 20),
              const SizedBox(width: 8),
              Text(
                widget.label, 
                style: TextStyle(
                  color: widget.color, 
                  fontWeight: FontWeight.w600, // Slightly less bold than before
                  fontSize: 14,
                  letterSpacing: 0.3
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
