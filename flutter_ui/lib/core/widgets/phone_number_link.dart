import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Clickable phone number widget
///
/// Displays a phone number that can be clicked to initiate a call.
class PhoneNumberLink extends StatelessWidget {
  final String phoneNumber;
  final TextStyle? style;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;

  const PhoneNumberLink({
    super.key,
    required this.phoneNumber,
    this.style,
    this.icon,
    this.iconSize,
    this.iconColor,
  });

  Future<void> _makePhoneCall(BuildContext context) async {
    // Remove all non-digit characters except +
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(scheme: 'tel', path: cleanNumber);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Не удалось открыть приложение для звонков'),
              backgroundColor: Color(0xFFF53178),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${e.toString()}'),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _makePhoneCall(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: iconSize ?? 16,
              color: iconColor ?? const Color(0xFF006FFD),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            phoneNumber,
            style: style ??
                const TextStyle(
                  color: Color(0xFF006FFD),
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
          ),
        ],
      ),
    );
  }
}
