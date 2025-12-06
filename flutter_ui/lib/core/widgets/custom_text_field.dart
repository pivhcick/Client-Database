import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom text field widget
///
/// A reusable text field that follows the app's design system.
class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? supportText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.supportText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2F3036), // Dark gray from design
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),

        // Text field
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          textCapitalization: textCapitalization,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2F3036),
            fontFamily: 'Inter',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8F9098), // Gray from design
              fontFamily: 'Inter',
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled ? Colors.white : const Color(0xFFF5F5F7),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFC5C6CC), // Border gray from design
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFC5C6CC),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF006FFD), // Secondary blue from design
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFF53178), // Primary pink from design
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFF53178),
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5E7),
                width: 1,
              ),
            ),
            counterText: '', // Hide character counter
          ),
        ),

        // Support text
        if (supportText != null) ...[
          const SizedBox(height: 4),
          Text(
            supportText!,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF8F9098),
              fontFamily: 'Inter',
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
