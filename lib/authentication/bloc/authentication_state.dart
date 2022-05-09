// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;
  final bool isFirstAccess;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.isFirstAccess = true,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.firstAccess()
      : this._(status: AuthenticationStatus.firstAccess);

  AuthenticationState(this.status, this.user, this.isFirstAccess);

  @override
  List<Object> get props => [status, user];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.toString().substring(21, status.toString().length),
      'user': user.toMap(),
      'isFirstAccess': isFirstAccess
    };
  }

  factory AuthenticationState.fromMap(Map<String, dynamic> map) {
    return AuthenticationState(
      (AuthenticationStatus.values.byName(map['status'])),
      User.fromMap(map['user']),
      map['isFirstAccess'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return "Printing status : " +
        status.toString() +
        " " +
        user.toString() +
        " already accessed : " +
        isFirstAccess.toString();
  }
}
