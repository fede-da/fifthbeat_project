part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.name = const Name.pure(),
      this.surname = const Surname.pure(),
      this.phoneNumber = const PhoneNumber.pure()});

  final FormzStatus status;
  final Username username;
  final Name name;
  final Surname surname;
  final PhoneNumber phoneNumber;

  RegistrationState copyWith({
    FormzStatus? status,
    Username? username,
    Name? name,
    Surname? surname,
    PhoneNumber? phoneNumber,
  }) {
    return RegistrationState(
        status: status ?? this.status,
        username: username ?? this.username,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  @override
  List<Object> get props => [status, username, name, surname, phoneNumber];
}
