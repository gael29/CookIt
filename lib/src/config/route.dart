import 'package:cookit/src/pages/authPage.dart';
import 'package:cookit/src/pages/profile.dart';
import 'package:cookit/src/pages/root_page.dart';
import 'package:cookit/src/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:cookit/src/pages/mainPage.dart';
import 'package:cookit/src/pages/recipe_detail.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainPage());

      case '/detail':
          return MaterialPageRoute(
            builder: (_) => RecipeDetailPage(
                  recipeId: args,
                ),
          );
          
      case '/auth':
          return MaterialPageRoute(builder: (_) => RootPage(auth: new Auth()));

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }
  // static Map<String,WidgetBuilder> getRoute(){
  //   return  <String, WidgetBuilder>{
  //         '/': (_) => MainPage(),
  //         '/detail': (_) => ProductDetailPage(data: model.id)
  //       };
  // }
   static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

}

