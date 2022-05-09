part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.name = const Name.pure()});

  final FormzStatus status;
  final Username username;
  final Password password;
  final Name name;

  RegistrationState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Name? name,
  }) {
    return RegistrationState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        name: name ?? this.name);
  }

  @override
  List<Object> get props => [status, username, password, name];
}
