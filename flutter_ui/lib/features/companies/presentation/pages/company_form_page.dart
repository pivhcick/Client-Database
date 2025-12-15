import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../domain/entities/company.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../providers/company_provider.dart';

/// Company form page (Create/Edit)
///
/// Universal form for creating or editing companies.
class CompanyFormPage extends StatefulWidget {
  final String? companyId; // null for create, non-null for edit

  const CompanyFormPage({
    super.key,
    this.companyId,
  });

  bool get isEditMode => companyId != null;

  @override
  State<CompanyFormPage> createState() => _CompanyFormPageState();
}

class _CompanyFormPageState extends State<CompanyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _contentController = TextEditingController();

  // Phone mask: +7 (###) ###-##-##
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  CompanyStatus _selectedStatus = CompanyStatus.potential;
  bool _isLoading = false;
  Company? _existingCompany;

  @override
  void initState() {
    super.initState();

    // Load existing company if editing
    if (widget.isEditMode) {
      _loadExistingCompany();
    }
  }

  Future<void> _loadExistingCompany() async {
    try {
      final companyProvider =
          Provider.of<CompanyProvider?>(context, listen: false);
      if (companyProvider == null) {
        throw Exception('Провайдер компаний не инициализирован');
      }

      final company = await companyProvider.getCompanyById(widget.companyId!);

      setState(() {
        _existingCompany = company;
        _nameController.text = company.name;

        // Extract only digits from phone number (remove +7 and any formatting)
        final digitsOnly = company.phone.replaceAll(RegExp(r'[^\d]'), '');
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

        _emailController.text = company.email ?? '';
        _addressController.text = company.address;
        _contentController.text = company.content ?? '';
        _selectedStatus = company.status;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка загрузки: ${e.toString()}'),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
        context.go('/');
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final companyProvider =
        Provider.of<CompanyProvider?>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final phone = '+7${_phoneMaskFormatter.getUnmaskedText()}';

    try {
      if (widget.isEditMode) {
        // Update existing company
        await companyProvider?.updateCompany(
          companyId: widget.companyId!,
          name: _nameController.text != _existingCompany!.name
              ? _nameController.text
              : null,
          phone: phone != _existingCompany!.phone ? phone : null,
          email: _emailController.text != (_existingCompany!.email ?? '')
              ? (_emailController.text.isEmpty ? null : _emailController.text)
              : null,
          address: _addressController.text != _existingCompany!.address
              ? _addressController.text
              : null,
          status: _selectedStatus != _existingCompany!.status
              ? _selectedStatus
              : null,
          content: _contentController.text != (_existingCompany!.content ?? '')
              ? (_contentController.text.isEmpty
                  ? null
                  : _contentController.text)
              : null,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Компания обновлена')),
          );
          context.go('/');
        }
      } else {
        // Create new company
        await companyProvider?.createCompany(
          name: _nameController.text,
          phone: phone,
          email: _emailController.text.isEmpty ? null : _emailController.text,
          address: _addressController.text,
          status: _selectedStatus,
          content:
              _contentController.text.isEmpty ? null : _contentController.text,
          createdByUserId: authProvider.currentUser!.id,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Компания создана')),
          );
          context.go('/');
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
        title: Text(
            widget.isEditMode ? 'Редактировать компанию' : 'Новая компания'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Name
                CustomTextField(
                  label: 'Название компании',
                  hintText: 'Введите название',
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название компании';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.business,
                    color: Color(0xFF8F9098),
                  ),
                ),
                const SizedBox(height: 16),

                // Phone
                CustomTextField(
                  label: 'Номер телефона',
                  hintText: '+7 (999) 999-99-99',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [_phoneMaskFormatter],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите номер телефона';
                    }
                    final unmasked = _phoneMaskFormatter.getUnmaskedText();
                    if (unmasked.length != 10) {
                      return 'Введите корректный номер телефона';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFF8F9098),
                  ),
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  label: 'Email (опционально)',
                  hintText: 'example@mail.ru',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return 'Неверный формат email';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF8F9098),
                  ),
                ),
                const SizedBox(height: 16),

                // Address
                CustomTextField(
                  label: 'Адрес',
                  hintText: 'Введите адрес',
                  controller: _addressController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите адрес';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF8F9098),
                  ),
                ),
                const SizedBox(height: 16),

                // Status selector
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Статус',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2F3036),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFC5C6CC)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CompanyStatus>(
                            value: _selectedStatus,
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: CompanyStatus.real,
                                child: Text('Реальный'),
                              ),
                              DropdownMenuItem(
                                value: CompanyStatus.potential,
                                child: Text('Потенциальный'),
                              ),
                              DropdownMenuItem(
                                value: CompanyStatus.lost,
                                child: Text('Потерянный'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedStatus = value;
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

                // Content (note)
                CustomTextField(
                  label: 'Заметка (опционально)',
                  hintText: 'Введите заметку о компании',
                  controller: _contentController,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
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
                  onPressed: () => context.go('/'),
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
