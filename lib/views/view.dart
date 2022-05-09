import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/bloc/authentication_bloc.dart';
import '../routes.dart';

class AppView extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthBlocListener(),
      onGenerateRoute: _appRouter.onGeneratedRoute,
    );
  }
}

class AuthBlocListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Joining app view ");
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (newContext, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            Navigator.of(context).pushNamed("/home");
            break;
          case AuthenticationStatus.unauthenticated:
            Navigator.of(context).pushNamed("/login");
            break;
          default:
            break;
        }
      },
      child: CircularProgressIndicator(),
    );
  }
}
