import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../login/cubit/registration_cubit.dart';
import 'registartion_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
        child: BlocProvider(
          create: (context) {
            return RegistrationCubit(
              authBloc: BlocProvider.of<AuthenticationBloc>(context),
            );
          },
          child: RegistrationForm(),
        ),
      ),
    );
  }
}
