import 'package:formz/formz.dart';

enum FieldValidationError { invalid }

class FieldValidation extends FormzInput<String, FieldValidationError> {
  const FieldValidation.pure() : super.pure('');
  const FieldValidation.dirty([String value = '']) : super.dirty(value);

  @override
  FieldValidationError? validator(String value) {
    return value.isNotEmpty ? null : FieldValidationError.invalid;
  }
}

extension Explanation on FieldValidationError {
  String? get names {
    switch(this) {
      case FieldValidationError.invalid:
        return "This is not a valid Field";
      default:
        return null;
    }
  }
}