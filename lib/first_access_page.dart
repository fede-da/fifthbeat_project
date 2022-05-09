import 'package:authentication_repository/authentication_repository.dart';
import 'package:fifthbeat_project/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstAccessPage extends StatefulWidget {
  FirstAccessPage({Key? key}) : super(key: key);

  @override
  State<FirstAccessPage> createState() => _FirstAccessPageState();
}

class _FirstAccessPageState extends State<FirstAccessPage> {
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width * 0.8;
    void _changeStatusAndGoToLogin() {
      BlocProvider.of<AuthenticationBloc>(context).add(
          AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
      // Navigator.pushNamed(context, "/login");
      return;
    }

    Widget _pageToShow(String asset) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(asset),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: SizedBox(
              height: 50,
              width: _width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff157DB3),
                ),
                child: Text("Inizia Ora!"),
                onPressed: () => (_controller.page ?? 0).round() < 2
                    ? _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceIn)
                    : _changeStatusAndGoToLogin(),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          _pageToShow("assets/images/primo_accesso_p1.png"),
          _pageToShow("assets/images/primo_accesso_p2.png"),
          _pageToShow("assets/images/primo_accesso_p3.png"),
        ],
      ),
    );
  }
}

// class _pageToShow extends StatelessWidget {
//   final String asset;

//   const _pageToShow({Key? key, required this.asset}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(asset),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
