import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
    // if (value == null) {
    //   // errorToShow = "Password is null";
    //   return PasswordValidationError.isNull;
    // } else if (value.isEmpty) {
    //   // errorToShow = "Password is empty";
    //   return PasswordValidationError.empty;
    // } else if (value.length > 7) {
    //   // errorToShow = "Password is too short, at least 8 characters";
    //   return PasswordValidationError.tooShort;
    // } else {
    //   return null;
    // }
  }
}
