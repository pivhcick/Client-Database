/// Form validators
class Validators {
  // Phone validation (Russian format: +7 (###) ###-##-##)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона';
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    // Check if it's a valid Russian phone number (11 digits starting with 7)
    if (digitsOnly.length != 11 || !digitsOnly.startsWith('7')) {
      return 'Неверный формат номера телефона';
    }

    return null;
  }

  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Email is optional in most cases
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Неверный формат email';
    }

    return null;
  }

  // Required email validation
  static String? validateRequiredEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите email';
    }

    return validateEmail(value);
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }

    if (value.length < 6) {
      return 'Пароль должен содержать минимум 6 символов';
    }

    return null;
  }

  // Password confirmation validation
  static String? validatePasswordConfirmation(
    String? value,
    String? password,
  ) {
    if (value == null || value.isEmpty) {
      return 'Подтвердите пароль';
    }

    if (value != password) {
      return 'Пароли не совпадают';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return fieldName != null
          ? 'Введите $fieldName'
          : 'Это поле обязательно для заполнения';
    }

    return null;
  }

  // Name validation (no numbers)
  static String? validateName(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return fieldName != null ? 'Введите $fieldName' : 'Введите имя';
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      return 'Имя не должно содержать цифры';
    }

    return null;
  }
}
