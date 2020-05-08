import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/pages/recipe_detail.dart';

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

