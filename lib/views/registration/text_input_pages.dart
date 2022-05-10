// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fifthbeat_project/views/registration/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../login/cubit/registration_cubit.dart';
import '../../login/models/name.dart';

typedef FutureCallback = Future<void> Function();

SizedBox _makeSpace([double size = 12]) => SizedBox(
      height: size,
    );

class TextInputPage extends StatelessWidget {
  int index;
  PageController controller;
  TextInputPage({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  Widget _makeButton(BuildContext context) {
    switch (index) {
      case 2:
        return _LastButtons(
            firstButtonText: "Invia codice di verifica",
            func: () => controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.bounceIn));
      case 3:
        return _LastButtons(
            firstButtonText: "Verifica numero",
            func: () => controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.bounceIn));
      case 4:
        return _LastButtons(
            firstButtonText: "Continua",
            func: () =>
                Navigator.of(context).pushNamed("/registrationCompleted"));
      default:
        return _LastButtons(
            firstButtonText: "Continua",
            func: () => controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.bounceIn));
    }
  }

  List<Widget> _makeColumn() {
    switch (index) {
      case 0:
        return [
          _makeTitle("Email"),
          _makeSpace(),
          _makeBody(
              "Inizia la registrazione inserendo il tuo indirizzo e-mail. "),
          _makeSpace(),
          _EmailInput(),
        ];
      case 1:
        return [
          _makeTitle("Il tuo nome"),
          _makeSpace(),
          _makeBody(
              "Il tuo nome serve per identificarti nelle prenotazioni, negli ordini e nelle comunicazioni con gli specialisti."),
          _makeSpace(),
          _NameInput(),
          _makeSpace(),
          _SurnameInput(),
        ];
      case 2:
        return [
          _makeTitle("Telefono"),
          _makeSpace(),
          _makeBody(
              "Il tuo numero di telefono serve per verifcare la tua identità e per farti contattare da specialisti e farmacie in caso di necessità. "),
          _makeSpace(),
          _PhoneNumberInput(),
        ];
      case 3:
        return [
          _makeTitle("Verifica il tuo numero di telefono"),
          _makeSpace(),
          _makeBody(
              "Abbiamo inviato un SMS al tuo numero di telefono con un codice a 6 cifre. Inserisci il codice e seleziona 'Verifica numero' "),
          _makeSpace(),
        ];
      case 4:
        return [
          _makeTitle("Password"),
          _makeSpace(),
          _makeBody(
              "Ti abbiamo inviato una mail con la password e un link. Potrai modificare la password direttamente dal tuo profilo."),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.77,
          child: _PageTracker(currentPage: index),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _makeColumn(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.8,
          child: _makeButton(context),
        )
      ],
    );
  }
}

Row _makeTitle(String title) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      ],
    );
Text _makeBody(String body) => Text(body, style: TextStyle());

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (newContext, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Indirizzo e-mail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            _makeSpace(4),
            TextField(
              key: const Key('loginForm_nameInput_textField'),
              onChanged: (name) => context
                  .read<RegistrationCubit>()
                  .changeName(Name.dirty(name)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color(0xff157DB3)),
                ),
                labelText: 'Inserisci la tua Email',
                errorText: state.name.invalid ? 'invalid email' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nome",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            _makeSpace(4),
            TextField(
              key: const Key('loginForm_nameInput_textField'),
              onChanged: (name) => context
                  .read<RegistrationCubit>()
                  .changeName(Name.dirty(name)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color(0xff157DB3)),
                ),
                labelText: 'Name',
                errorText: state.username.invalid ? 'invalid name' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SurnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => previous.surname != current.surname,
      builder: (context, state) {
        return Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cognome",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          _makeSpace(4),
          TextField(
            key: const Key('loginForm_SurnameInput_textField'),
            onChanged: (surname) => context
                .read<RegistrationCubit>()
                .changeSurname(Surname.dirty(surname)),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xff157DB3)),
              ),
              labelText: 'Surname',
              errorText: state.username.invalid ? 'invalid username' : null,
            ),
          ),
        ]);
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Numero di telefono",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            _makeSpace(4),
            TextField(
              keyboardType: TextInputType.number,
              key: const Key('loginForm_phoneNumberInput_textField'),
              onChanged: (phoneNumber) => context
                  .read<RegistrationCubit>()
                  .changePhoneNumber(PhoneNumber.dirty(phoneNumber)),
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Color(0xff157DB3)),
                ),
                labelText: 'Inserisci il tuo numero',
                errorText:
                    state.phoneNumber.invalid ? 'invalid phoneNumber' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Register'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<RegistrationCubit>().submit();
                      }
                    : null,
              );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.of(context).pushNamed("/login"),
        child: Text("Or login here!"));
  }
}

class _LastButtons extends StatelessWidget {
  String firstButtonText;
  FutureCallback func;

  _LastButtons({
    Key? key,
    required this.firstButtonText,
    required this.func,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff157DB3),
            ),
            onPressed: () async {
              func();
            },
            child: Text(firstButtonText)),
        TextButton(
            onPressed: () => Navigator.of(context).pushNamed("/home"),
            child: Text(
              "Entra come ospite",
              style: TextStyle(color: Color(0xff157DB3)),
            ))
      ]),
    );
  }
}

class _PageTracker extends StatelessWidget {
  int currentPage;
  _PageTracker({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  Container _makeContainer(Color color) => Container(
        width: 8,
        height: 8,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(2), color: color),
      );
  SizedBox _makeSpace() => SizedBox(
        width: 10,
      );

  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [
      _makeContainer(Color(0xffE2E5EB)),
      _makeSpace(),
      _makeContainer(Color(0xffE2E5EB)),
      _makeSpace(),
      _makeContainer(Color(0xffE2E5EB)),
      _makeSpace(),
      _makeContainer(Color(0xffE2E5EB)),
      _makeSpace(),
      _makeContainer(Color(0xffE2E5EB))
    ];
    containers[currentPage * 2] = _makeContainer(Color(0xff8B99AD));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: containers,
    );
  }
}
