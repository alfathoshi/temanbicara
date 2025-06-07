import 'package:fancy_password_field/fancy_password_field.dart';

class ValidationUtils {
  static final Set<ValidationRule> passwordRules = {
    MinCharactersValidationRule(8),
    UppercaseValidationRule(),
    LowercaseValidationRule(),
    SpecialCharacterValidationRule(),
  };

  static bool isPasswordValid(String value) {
    return passwordRules.every((rule) => rule.validate(value));
  }
}
