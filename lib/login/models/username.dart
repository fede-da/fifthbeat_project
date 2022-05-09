import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
    // if (value == null)
    //   return UsernameValidationError.isNull;
    // else if (value.isEmpty)
    //   return UsernameValidationError.empty;
    // else if (value.length < 4)
    //   return UsernameValidationError.tooShort;
    // else
    //   return null;
  }
}
