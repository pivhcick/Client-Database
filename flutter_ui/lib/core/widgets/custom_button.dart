import 'package:flutter/material.dart';

/// Button size variants
enum ButtonSize {
  small, // 36px height
  medium, // 40px height
  large, // 48px height
}

/// Button type variants
enum ButtonType {
  primary, // Blue background
  secondary, // Pink background
  outline, // Transparent with border
  text, // Just text, no background
}

/// Custom button widget
///
/// A reusable button that follows the app's design system.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final bool iconAtEnd;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.iconAtEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get height based on size
    final double height = switch (size) {
      ButtonSize.small => 36,
      ButtonSize.medium => 40,
      ButtonSize.large => 48,
    };

    // Get font size based on size
    final double fontSize = switch (size) {
      ButtonSize.small => 11,
      ButtonSize.medium => 12,
      ButtonSize.large => 13,
    };

    // Get colors based on type
    final Color backgroundColor = switch (type) {
      ButtonType.primary => const Color(0xFF006FFD), // Secondary blue
      ButtonType.secondary => const Color(0xFFF53178), // Primary pink
      ButtonType.outline => Colors.transparent,
      ButtonType.text => Colors.transparent,
    };

    final Color foregroundColor = switch (type) {
      ButtonType.primary => Colors.white,
      ButtonType.secondary => Colors.white,
      ButtonType.outline => const Color(0xFF006FFD),
      ButtonType.text => const Color(0xFF006FFD),
    };

    final BorderSide? borderSide = switch (type) {
      ButtonType.outline => const BorderSide(
          color: Color(0xFF006FFD),
          width: 1,
        ),
      _ => null,
    };

    final double elevation = switch (type) {
      ButtonType.text => 0,
      _ => 0,
    };

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide ?? BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          disabledBackgroundColor: backgroundColor.withOpacity(0.5),
          disabledForegroundColor: foregroundColor.withOpacity(0.5),
        ),
        child: isLoading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null && !iconAtEnd) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      letterSpacing: 0,
                    ),
                  ),
                  if (icon != null && iconAtEnd) ...[
                    const SizedBox(width: 8),
                    icon!,
                  ],
                ],
              ),
      ),
    );
  }
}
