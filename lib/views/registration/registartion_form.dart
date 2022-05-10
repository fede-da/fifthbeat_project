import 'package:fifthbeat_project/views/registration/text_input_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../login/cubit/registration_cubit.dart';

class RegistrationForm extends StatelessWidget {
  final _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: BlocListener<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Authentication Failure')),
                );
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: PageView.builder(
                controller: _controller,
                itemCount: 5,
                itemBuilder: (_, index) =>
                    TextInputPage(index: index, controller: _controller)),
          ),
        ));
  }
}
