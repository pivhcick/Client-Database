import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validatePhone', () {
      test('should return null for valid phone number', () {
        expect(Validators.validatePhone('+7 (912) 345-67-89'), isNull);
        expect(Validators.validatePhone('+79123456789'), isNull);
      });

      test('should return error for invalid phone number', () {
        expect(Validators.validatePhone(''), isNotNull);
        expect(Validators.validatePhone('123'), isNotNull);
        expect(Validators.validatePhone('+7 912'), isNotNull);
      });

      test('should return error for null', () {
        expect(Validators.validatePhone(null), isNotNull);
      });
    });

    group('validateEmail', () {
      test('should return null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), isNull);
        expect(Validators.validateEmail('user.name@domain.co.uk'), isNull);
      });

      test('should return null for empty email (optional)', () {
        // Email is optional according to validator implementation
        expect(Validators.validateEmail(''), isNull);
        expect(Validators.validateEmail(null), isNull);
      });

      test('should return error for invalid email', () {
        expect(Validators.validateEmail('invalid'), isNotNull);
        expect(Validators.validateEmail('test@'), isNotNull);
        expect(Validators.validateEmail('@example.com'), isNotNull);
      });
    });

    group('validatePassword', () {
      test('should return null for valid password', () {
        expect(Validators.validatePassword('password123'), isNull);
        expect(Validators.validatePassword('12345678'), isNull);
      });

      test('should return error for short password', () {
        expect(Validators.validatePassword(''), isNotNull);
        expect(Validators.validatePassword('12345'), isNotNull);
      });

      test('should return error for null', () {
        expect(Validators.validatePassword(null), isNotNull);
      });
    });

    group('validateName', () {
      test('should return null for valid name', () {
        expect(Validators.validateName('Иван'), isNull);
        expect(Validators.validateName('Петров'), isNull);
      });

      test('should return error for name with numbers', () {
        expect(Validators.validateName('Иван123'), isNotNull);
      });

      test('should return error for empty name', () {
        expect(Validators.validateName(''), isNotNull);
      });

      test('should return error for null', () {
        expect(Validators.validateName(null), isNotNull);
      });
    });

    group('validateRequired', () {
      test('should return null for non-empty value', () {
        expect(Validators.validateRequired('text'), isNull);
      });

      test('should return error for empty value', () {
        expect(Validators.validateRequired(''), isNotNull);
      });

      test('should return error for null', () {
        expect(Validators.validateRequired(null), isNotNull);
      });
    });

    group('validateRequiredEmail', () {
      test('should return null for valid email', () {
        expect(Validators.validateRequiredEmail('test@example.com'), isNull);
      });

      test('should return error for empty email', () {
        expect(Validators.validateRequiredEmail(''), isNotNull);
      });

      test('should return error for invalid email', () {
        expect(Validators.validateRequiredEmail('invalid'), isNotNull);
      });
    });

    group('validatePasswordConfirmation', () {
      test('should return null when passwords match', () {
        expect(Validators.validatePasswordConfirmation('password', 'password'), isNull);
      });

      test('should return error when passwords do not match', () {
        expect(Validators.validatePasswordConfirmation('password1', 'password2'), isNotNull);
      });

      test('should return error for empty confirmation', () {
        expect(Validators.validatePasswordConfirmation('', 'password'), isNotNull);
      });
    });
  });
}
