import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../auth/domain/entities/user.dart' as entities;
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/validators.dart';
import '../providers/user_provider.dart';

/// User form page (Create/Edit)
///
/// Universal form for creating or editing users.
class UserFormPage extends StatefulWidget {
  final String? userId; // null for create, non-null for edit

  const UserFormPage({
    super.key,
    this.userId,
  });

  bool get isEditMode => userId != null;

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Phone mask: +7 (###) ###-##-##
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  entities.UserRole _selectedRole = entities.UserRole.regular;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  entities.User? _existingUser;

  @override
  void initState() {
    super.initState();

    // Load existing user if editing
    if (widget.isEditMode) {
      _loadExistingUser();
    }
  }

  Future<void> _loadExistingUser() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = await userProvider.getUserById(widget.userId!);

      setState(() {
        _existingUser = user;

        // Extract only digits from phone number (remove +7 and any formatting)
        final digitsOnly = user.phone.replaceAll(RegExp(r'[^\d]'), '');
        // Remove leading 7 if present to get the 10 digits for the mask
        final phoneDigits = digitsOnly.startsWith('7')
            ? digitsOnly.substring(1)
            : digitsOnly;

        // Apply mask to the phone digits
        final maskedPhone = _phoneMaskFormatter.formatEditUpdate(
          const TextEditingValue(text: ''),
          TextEditingValue(text: phoneDigits),
        );

        // Set formatted phone to controller
        _phoneController.value = maskedPhone;

        _firstNameController.text = user.firstName;
        _lastNameController.text = user.lastName;
        _middleNameController.text = user.middleName;
        _emailController.text = user.email;
        _selectedRole = user.role;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка загрузки: ${e.toString()}'),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
        context.go('/users');
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    // Password required only when creating new user
    if (!widget.isEditMode) {
      return Validators.validatePassword(value);
    }

    // In edit mode, password is optional
    if (value != null && value.isNotEmpty) {
      return Validators.validatePassword(value);
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (!widget.isEditMode || _passwordController.text.isNotEmpty) {
      if (value != _passwordController.text) {
        return 'Пароли не совпадают';
      }
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final phone = '+7${_phoneMaskFormatter.getUnmaskedText()}';

    try {
      if (widget.isEditMode) {
        // Update existing user
        await userProvider.updateUser(
          userId: widget.userId!,
          phone: phone != _existingUser!.phone ? phone : null,
          firstName: _firstNameController.text != _existingUser!.firstName
              ? _firstNameController.text
              : null,
          lastName: _lastNameController.text != _existingUser!.lastName
              ? _lastNameController.text
              : null,
          middleName: _middleNameController.text != _existingUser!.middleName
              ? _middleNameController.text
              : null,
          email: _emailController.text != _existingUser!.email
              ? _emailController.text
              : null,
          role: _selectedRole != _existingUser!.role ? _selectedRole : null,
          newPassword: _passwordController.text.isNotEmpty
              ? _passwordController.text
              : null,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Пользователь обновлен')),
          );
          context.go('/users');
        }
      } else {
        // Create new user
        await userProvider.createUser(
          phone: phone,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          middleName: _middleNameController.text,
          email: _emailController.text,
          role: _selectedRole,
          password: _passwordController.text,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Пользователь создан')),
          );
          context.go('/users');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/users'),
        ),
        title: Text(
          widget.isEditMode
              ? 'Редактировать пользователя'
              : 'Новый пользователь',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006FFD),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Phone
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

                // Last name
                CustomTextField(
                  label: 'Фамилия',
                  hintText: 'Введите фамилию',
                  controller: _lastNameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите фамилию';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // First name
                CustomTextField(
                  label: 'Имя',
                  hintText: 'Введите имя',
                  controller: _firstNameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите имя';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Middle name
                CustomTextField(
                  label: 'Отчество',
                  hintText: 'Введите отчество',
                  controller: _middleNameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите отчество';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  label: 'Email',
                  hintText: 'example@mail.ru',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Неверный формат email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Role selector
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Роль',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2F3036),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFC5C6CC)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<entities.UserRole>(
                            value: _selectedRole,
                            isExpanded: true,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2F3036),
                              fontFamily: 'Inter',
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: entities.UserRole.regular,
                                child: Text('Пользователь'),
                              ),
                              DropdownMenuItem(
                                value: entities.UserRole.admin,
                                child: Text('Администратор'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedRole = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  label: widget.isEditMode ? 'Новый пароль (опционально)' : 'Пароль',
                  hintText: widget.isEditMode
                      ? 'Оставьте пустым, чтобы не менять'
                      : 'Минимум 6 символов',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
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
                const SizedBox(height: 16),

                // Confirm password
                CustomTextField(
                  label: 'Подтвердите пароль',
                  hintText: 'Введите пароль еще раз',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  validator: _validateConfirmPassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF8F9098),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF8F9098),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Submit button
                CustomButton(
                  text: widget.isEditMode ? 'Сохранить' : 'Создать',
                  onPressed: _handleSubmit,
                  isFullWidth: true,
                  size: ButtonSize.large,
                  type: ButtonType.primary,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 16),

                // Cancel button
                CustomButton(
                  text: 'Отмена',
                  onPressed: () => context.go('/users'),
                  isFullWidth: true,
                  size: ButtonSize.large,
                  type: ButtonType.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
