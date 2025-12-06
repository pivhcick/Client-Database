import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';

/// Login page
///
/// Allows users to login with phone number and password.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Phone number mask: +7 (###) ###-##-##
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get phone without mask
    final phone = _phoneMaskFormatter.getUnmaskedText();
    final password = _passwordController.text;

    // Login
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.login(
        phone: '+7$phone',
        password: password,
      );

      // Navigation handled by GoRouter redirect
    } catch (e) {
      // Error is already set in AuthProvider
      // Show error dialog
      if (mounted) {
        _showErrorDialog(authProvider.errorMessage ?? 'Ошибка входа');
      }
    }
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo or app name
                  const Text(
                    'Комплексное обеспечение',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F3036),
                      fontFamily: 'Sora',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'CRM система для управления клиентами',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8F9098),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 48),

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
                  const SizedBox(height: 16),

                  // Password field
                  CustomTextField(
                    label: 'Пароль',
                    hintText: 'Введите пароль',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: Validators.validatePassword,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xFF8F9098),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF8F9098),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Forgot password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to password reset
                        // TODO: Implement when GoRouter is set up
                      },
                      child: const Text(
                        'Забыли пароль?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF006FFD),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login button
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return CustomButton(
                        text: 'Войти',
                        onPressed: _handleLogin,
                        isFullWidth: true,
                        size: ButtonSize.large,
                        type: ButtonType.primary,
                        isLoading: authProvider.isLoading,
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Version info
                  const Text(
                    'Версия 1.0.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8F9098),
                      fontFamily: 'Inter',
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
