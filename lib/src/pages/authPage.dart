import 'package:flutter/material.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:flutter_login/flutter_login.dart';
//import 'dashboard_screen.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      logo: 'assets/lime.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
      //  
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        usernameHint: 'Email',
        passwordHint: 'Mot de passe',
        confirmPasswordHint: 'Confirmer',
        loginButton: 'Connexion',
        signupButton: 'Inscription',
        forgotPasswordButton: 'Mot de passe oublié ?',
        recoverPasswordButton: 'Récuperer mon mot de passe',
        goBackButton: 'Retour',
        confirmPasswordError: 'Ne correspond pas',
        recoverPasswordDescription:
            'Un mail de récupération de mot de passe va vous être envoyé',
        recoverPasswordSuccess: 'Password rescued successfully',
        recoverPasswordIntro:'Récupérez votre mot de passe'
      ),


         theme: LoginTheme(
         primaryColor: LightColor.main,
         accentColor: LightColor.main,
         errorColor: LightColor.main,
        titleStyle: TextStyle(
          // color: Colors.greenAccent,
          // fontFamily: 'Quicksand',
          // letterSpacing: 4,
        
        ),
      //   bodyStyle: TextStyle(
      //     fontStyle: FontStyle.italic,
      //     decoration: TextDecoration.underline,
      //   ),
      //   textFieldStyle: TextStyle(
      //     color: Colors.orange,
      //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
      //   ),
      //   buttonStyle: TextStyle(
      //     fontWeight: FontWeight.w800,
      //     color: Colors.yellow,
      //   ),
      //   cardTheme: CardTheme(
      //     color: Colors.yellow.shade100,
      //     elevation: 5,
      //     margin: EdgeInsets.only(top: 15),
      //     shape: ContinuousRectangleBorder(
      //         borderRadius: BorderRadius.circular(100.0)),
      //   ),
      //   inputTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.purple.withOpacity(.1),
      //     contentPadding: EdgeInsets.zero,
      //     errorStyle: TextStyle(
      //       backgroundColor: Colors.orange,
      //       color: Colors.white,
      //     ),
      //     labelStyle: TextStyle(fontSize: 12),
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
      //      // borderRadius: inputBorder,
      //     ),
      //     focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
      //    //   borderRadius: inputBorder,
      //     ),
      //     errorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
      //      // borderRadius: inputBorder,
      //     ),
      //     focusedErrorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
      //    //   borderRadius: inputBorder,
      //     ),
      //     disabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey, width: 5),
      //     //  borderRadius: inputBorder,
      //     ),
      //   ),
        buttonTheme: LoginButtonTheme(
          splashColor: LightColor.main,
          backgroundColor: LightColor.main,
          highlightColor: Colors.lightGreen,
          elevation: 9.0,
          highlightElevation: 6.0,
          // shape: BeveledRectangleBorder(
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
    );
  }
}