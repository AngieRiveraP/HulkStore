import 'package:formz/formz.dart';

enum UrlValidationError { invalid }

class UrlValidation extends FormzInput<String, UrlValidationError> {
  const UrlValidation.pure() : super.pure('');
  const UrlValidation.dirty([String value = '']) : super.dirty(value);

  static final RegExp _urlRegExp = RegExp(
    r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
  );

  @override
  UrlValidationError? validator(String value) {
    return _urlRegExp.hasMatch(value) ? null : UrlValidationError.invalid;
  }
}

extension Explanation on UrlValidationError {
  String? get name {
    switch(this) {
      case UrlValidationError.invalid:
        return "This is not a valid Url";
      default:
        return null;
    }
  }
}