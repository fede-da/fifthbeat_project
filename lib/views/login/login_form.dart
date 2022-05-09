import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../login/cubit/login_cubit.dart';
import '../../login/models/password.dart';
import '../../login/models/username.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 90,
            ),
            _RowElement(text: "Email"),
            const Padding(padding: EdgeInsets.all(4)),
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _RowElement(text: "Password"),
            const Padding(padding: EdgeInsets.all(4)),
            _PasswordInput(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Recupera password",
                    style: TextStyle(
                      color: Color(0xff157DB3),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            _RegistrationButton(),
            _ProceedAsGuest()
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) => context
              .read<LoginCubit>()
              .changeUsername(Username.dirty(username)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0xff157DB3)),
            ),
            labelText: 'Inserisci la tua email',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<LoginCubit>()
              .changePassword(Password.dirty(password)),
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xff157DB3))),
            labelText: 'Inserisci la tua password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff157DB3),
                ),
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Inizia ora'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginCubit>().submit();
                      }
                    : null,
              );
      },
    );
  }
}

class _RegistrationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Non hai un account?"),
        TextButton(
            onPressed: () => Navigator.of(context).pushNamed("/register"),
            child: Text(
              "Registrati",
              style: TextStyle(color: Color(0xff157DB3)),
            )),
      ],
    );
  }
}

class _RowElement extends StatelessWidget {
  final String text;
  const _RowElement({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ProceedAsGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () => Navigator.of(context).pushNamed("/home"),
        child: Text(
          "Entra come ospite",
          style: TextStyle(color: Color(0xff157DB3)),
        ),
      ),
    );
  }
}
