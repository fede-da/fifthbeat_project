import 'package:fifthbeat_project/first_access_page.dart';
import 'package:fifthbeat_project/views/registration_completed.dart';
import 'package:flutter/material.dart';

import 'views/home.dart';
import 'views/login/login_page.dart';
import 'views/permessi.dart';
import 'views/registration/registration_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      //  case '/second' :
      //       return MaterialPageRoute(
      //   builder : (_) => Second(),
      //      );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => RegistrationPage(),
        );
      case '/firstAccess':
        return MaterialPageRoute(
          builder: (_) => FirstAccessPage(),
        );
      case '/permessi':
        return MaterialPageRoute(
          builder: (_) => Permessi(),
        );
      case '/registrationCompleted':
        return MaterialPageRoute(
          builder: (_) => RegistrationCompleted(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
    }
  }
}
