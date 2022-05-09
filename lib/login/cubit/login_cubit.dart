import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../models/password.dart';
import '../models/username.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthenticationBloc authBloc;

  LoginCubit({required this.authBloc}) : super(LoginState()) {}

  void changeUsername(
    Username username,
  ) {
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void changePassword(
    Password password,
  ) {
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void submit() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await authBloc.login(
          username: state.username.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return authBloc
          .add(AuthenticationStatusChanged(AuthenticationStatus.authenticated));
    }
  }
}


// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc({
//     required AuthenticationRepository authenticationRepository,
//   })  : _authenticationRepository = authenticationRepository,
//         super(const LoginState()) {
//     on<LoginUsernameChanged>(_onUsernameChanged);
//     on<LoginPasswordChanged>(_onPasswordChanged);
//     on<LoginSubmitted>(_onSubmitted);
//   }

//   final AuthenticationRepository _authenticationRepository;

//   void _onUsernameChanged(
//     LoginUsernameChanged event,
//     Emitter<LoginState> emit,
//   ) {
//     final username = Username.dirty(event.username);
//     emit(state.copyWith(
//       username: username,
//       status: Formz.validate([state.password, username]),
//     ));
//   }

//   void _onPasswordChanged(
//     LoginPasswordChanged event,
//     Emitter<LoginState> emit,
//   ) {
//     final password = Password.dirty(event.password);
//     emit(state.copyWith(
//       password: password,
//       status: Formz.validate([password, state.username]),
//     ));
//   }

//   void _onSubmitted(
//     LoginSubmitted event,
//     Emitter<LoginState> emit,
//   ) async {
//     if (state.status.isValidated) {
//       emit(state.copyWith(status: FormzStatus.submissionInProgress));
//       try {
//         await _authenticationRepository.logIn(
//           username: state.username.value,
//           password: state.password.value,
//         );
//         emit(state.copyWith(status: FormzStatus.submissionSuccess));
//       } catch (_) {
//         emit(state.copyWith(status: FormzStatus.submissionFailure));
//       }
//     }
//   }
// }
