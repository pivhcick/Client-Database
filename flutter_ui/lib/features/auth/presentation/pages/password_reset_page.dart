import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';

/// Password reset page
///
/// Step 1: Enter phone number to request password reset.
/// In production, this would send SMS/email with verification code.
class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  // Phone number mask: +7 (###) ###-##-##
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleRequestReset() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get phone without mask
    final phone = _phoneMaskFormatter.getUnmaskedText();

    // Request password reset
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.requestPasswordReset('+7$phone');

      // Show success message
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      // Error is already set in AuthProvider
      // Show error dialog
      if (mounted) {
        _showErrorDialog(
          authProvider.errorMessage ?? 'Ошибка запроса сброса пароля',
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Запрос отправлен'),
        content: const Text(
          'Инструкции по сбросу пароля отправлены на указанный номер телефона.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to login
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2F3036)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Сброс пароля',
          style: TextStyle(
            color: Color(0xFF2F3036),
            fontFamily: 'Sora',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),

                // Icon
                const Icon(
                  Icons.lock_reset,
                  size: 64,
                  color: Color(0xFF006FFD),
                ),
                const SizedBox(height: 24),

                // Description
                const Text(
                  'Введите номер телефона',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3036),
                    fontFamily: 'Sora',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Мы отправим вам инструкции по восстановлению пароля',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8F9098),
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 32),

                // Phone field
                CustomTextField(
                  label: 'Номер телефона',
                  hintText: '+7 (999) 999-99-99',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [_phoneMaskFormatter],
                  validator: Validators.validatePhone,
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFF8F9098),
                  ),
                ),
                const SizedBox(height: 24),

                // Submit button
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return CustomButton(
                      text: 'Отправить',
                      onPressed: _handleRequestReset,
                      isFullWidth: true,
                      size: ButtonSize.large,
                      type: ButtonType.primary,
                      isLoading: authProvider.isLoading,
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Back to login
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Вернуться к входу',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF006FFD),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
