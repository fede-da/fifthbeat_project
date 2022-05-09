import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:models/models.dart';

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
      status: Formz.validate([state.password, username, state.name]),
    ));
  }

  void changeName(
    Name name,
  ) {
    emit(state.copyWith(
      name: name,
      status: Formz.validate([state.password, state.username, name]),
    ));
  }

  void changePassword(
    Password password,
  ) {
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username, state.name]),
    ));
  }

  void submit() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      User? user = await authBloc.register(
        name: state.name.value,
        username: state.username.value,
        password: state.password.value,
      );
      if (user.token == "token") {
        return emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return authBloc
          .add(AuthenticationStatusChanged(AuthenticationStatus.authenticated));
    }
  }
}
