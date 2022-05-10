import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fifthbeat_project/views/registration/models/models.dart';
import 'package:formz/formz.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../models/name.dart';
import '../models/password.dart';
import '../models/username.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  AuthenticationBloc authBloc;
  RegistrationCubit({
    required this.authBloc,
  }) : super(RegistrationState());

  void changeUsername(
    Username username,
  ) {
    emit(state.copyWith(
      username: username,
      status: Formz.validate(
          [username, state.name, state.surname, state.phoneNumber]),
    ));
  }

  void changeName(
    Name name,
  ) {
    emit(state.copyWith(
      name: name,
      status: Formz.validate(
          [state.username, name, state.surname, state.phoneNumber]),
    ));
  }

  void changeSurname(
    Surname surname,
  ) {
    emit(state.copyWith(
      surname: surname,
      status: Formz.validate(
          [state.username, state.name, surname, state.phoneNumber]),
    ));
  }

  void changePhoneNumber(
    PhoneNumber phoneNumber,
  ) {
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate(
          [state.username, state.name, state.surname, phoneNumber]),
    ));
  }

  void submit() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return authBloc
          .add(AuthenticationStatusChanged(AuthenticationStatus.authenticated));
    }
  }
}
