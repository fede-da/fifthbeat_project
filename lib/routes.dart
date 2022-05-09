import 'package:flutter/material.dart';

import 'views/home.dart';
import 'views/login/login_page.dart';
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
      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
    }
  }
}
