import 'dart:async';
import 'dart:convert';

import 'package:models/models.dart';

import 'models/user_credentials.dart';
import 'package:http/http.dart' as http;

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  late final StreamController<AuthenticationStatus> _controller;

  AuthenticationRepository() {
    _controller = StreamController<AuthenticationStatus>();
  }

  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  Future<User> _login(UserCredentials user) async {
    User? userFetched;
    //print(user);
    http.Response response = await http.post(
      Uri.parse("http://80.211.57.191:8000/customer_survey/api/login"),
      body: user.toMap(),
    );
    if (response.statusCode == 200) {
      print("Risposta dal server : " + response.statusCode.toString());
      try {
        userFetched = User.fromJson(jsonDecode(response.body)['data']);
        print(userFetched);
      } catch (e) {
        print(e);
      }
      print("End");
      return userFetched!;
    } else {
      print("Login Failure from repository");
      throw Exception("Email already taken");
    }
  }

  /// {@template}
  /// Adds authenticated status to AuthenticationController
  void authenticate() {
    _controller.add(AuthenticationStatus.authenticated);
  }

  /// {@template}
  /// Adds authenticated status to AuthenticationController
  void unauthenticate() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<User?> logIn({
    required String username,
    required String password,
  }) async {
    // try {
    //   return await _login(UserCredentials(email: username, password: password));
    // } catch (e) {
    //   return null;
    // }
    return User.empty;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<User?> register(
      {required String name,
      required String username,
      required String password}) async {
    http.Response response = await http.post(
      Uri.parse("http://80.211.57.191:8000/customer_survey/api/register"),
      body: {'name': name, 'email': username, 'password': password},
    );
    if (response.statusCode == 200) {
      try {
        User user = User.fromJson(jsonDecode(response.body)['data']);
        if (user.token != "token") {
          return user;
        }
        throw Exception("User data not well parsed after registration");
      } catch (e) {
        return null;
      }
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
