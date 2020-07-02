import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookit/src/config/SizeConfig.dart';
import 'package:cookit/src/database/database.dart';
import 'package:cookit/src/model/recipe.dart';
import 'package:cookit/src/model/user.dart';
import 'package:cookit/src/services/authentication.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sqflite/sqflite.dart';

class AuthPage extends StatefulWidget {
  AuthPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  final firestoreInstance = Firestore.instance;

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var item = 1;
  final _reg = GlobalKey<FormState>();
  final _sign = GlobalKey<FormState>();
  final _reset = GlobalKey<FormState>();
  final _user = User();

  String validatePassword;
  String _email;
  String _password;
  String _errorMessage;
  bool _isLoading = false;

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    String userId = "";
    try {
      if (item == 1) {
        userId = await widget.auth.signIn(_email, _password);
        print('Signed in: $userId');
        List<Map> _fav = await DBProvider.db.getFavList();
        List<Map> _plan = await DBProvider.db.getPlanList();
        widget.firestoreInstance.collection("users").document(userId).setData({
          "Fav": _fav,
          "Plan": _plan,
        }, merge: true).then((_) {
          print("success!");
        });
      } else if (item == 2) {
        userId = await widget.auth.signUp(_email, _password);
        //widget.auth.sendEmailVerification();
        //_showVerifyEmailSentDialog();
        print('Signed up user: $userId');

        List<Map> _fav = await DBProvider.db.getFavList();
        List<Map> _plan = await DBProvider.db.getPlanList();

        widget.firestoreInstance.collection("users").document(userId).setData({
          "Firstname": _user.firstName,
          "Lastname": _user.lastName,
          "Image" :"https://eu.ui-avatars.com/api/?size=128&rounded=true&background=ffffff&color=00d181&name="+_user.firstName+"+"+_user.lastName,
          "Email": _user.email,
          "Fav": _fav,
          "Plan": _plan,
        }).then((_) {
          Navigator.of(context).popAndPushNamed('/auth');
        });
      } else if (item == 3) {
        await widget.auth.resetPassword(_email);
        //widget.auth.sendEmailVerification();
        //_showVerifyEmailSentDialog();
        print('Signed up user: $userId');
        Navigator.of(context).popAndPushNamed('/auth');
        Flushbar(
          message: "Un email vous a été envoyé pour changer de mot de passe",
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: LightColor.main,
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: LightColor.main,
        )..show(context);
      }
      setState(() {
        _isLoading = false;
      });

      if (userId.length > 0 && userId != null && item == 1) {
        widget.loginCallback();
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
        Flushbar(
          message: _errorMessage,
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: LightColor.main,
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: LightColor.main,
        )..show(context);
        // _formKey.currentState.reset();
      });
    }
  }

  // Widget _fav() {
  //   return FutureBuilder<List<Recipe>>(
  //       future: DBProvider.db.getAllFav(),
  //       builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //             itemCount: snapshot.data.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               Recipe item = snapshot.data[index];
  //             },
  //           );
  //         } else {
  //           return Container(
  //               margin: const EdgeInsets.only(top: 50.0),
  //               child: SpinKitRotatingCircle(
  //                 color: LightColor.main,
  //                 size: 50.0,
  //               ));
  //         }
  //       },
  //     );
  // }

  Widget _header(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/lime.png',
                  width: SizeConfig.screenWidth * 0.4,
                ),
              ],
            ),
            width: double.infinity,
            height: SizeConfig.screenHeight * 0.3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [LightColor.main, LightColor.green2])),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: CircleAvatar(
              radius: SizeConfig.safeBlockVertical * 4,
              backgroundColor: LightColor.background,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: LightColor.main,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Center(
      child: Text(
        'Cook It',
        style: TextStyle(
            fontFamily: 'Kathen',
            color: LightColor.main,
            fontSize: SizeConfig.screenHeight * 0.07),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _login() {
    return Form(
        key: _sign,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ce champ est requis';
                    } else if (EmailValidator.validate(value) == false) {
                      return 'Entrez un email valide';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    //print(value);
                  },
                  onSaved: (val) {
                    setState(() => _user.email = val);
                  },
                  cursorColor: LightColor.main,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.email,
                          color: LightColor.main,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    validatePassword = value;
                  },
                  onSaved: (val) {
                    setState(() => _user.password = val);
                  },
                  cursorColor: LightColor.main,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Mot de passe",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.lock,
                          color: LightColor.main,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: LightColor.main),
                    child: FlatButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_sign.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          _sign.currentState.save();
                          _email = _user.email;
                          _password = _user.password;
                          // print(_user.firstName);
                          // print(_user.lastName);
                          // print(_user.email);
                          // print(_user.password);
                          validateAndSubmit();
                        }
                      },
                      child: Text(
                        "Connexion",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ))),
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                child: Text(
                  "MOT DE PASSE OUBLIÉ ?",
                  style: TextStyle(
                      color: LightColor.main,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  setState(() {
                    item = 3;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/fb.png',
                  width: SizeConfig.screenWidth * 0.1,
                ),
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'assets/google.png',
                  width: SizeConfig.screenWidth * 0.1,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Vous n'avez pas de compte ? ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockVertical * 2.5,
                  fontWeight: FontWeight.normal),
            ),
            InkWell(
              child: Text("Inscription",
                  style: TextStyle(
                      color: LightColor.main,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.safeBlockVertical * 2.5)),
              onTap: () {
                setState(() {
                  item = 2;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _register() {
    return Form(
      key: _reg,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
                onChanged: (String value) {
                  //print(value);
                },
                onSaved: (val) {
                  setState(() => _user.firstName = val);
                },
                cursorColor: LightColor.main,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Prénom",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.person,
                        color: LightColor.main,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
                onChanged: (String value) {
                  //print(value);
                },
                onSaved: (val) {
                  setState(() => _user.lastName = val);
                },
                cursorColor: LightColor.main,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Nom",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.person,
                        color: LightColor.main,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ce champ est requis';
                  } else if (EmailValidator.validate(value) == false) {
                    return 'Entrez un email valide';
                  }
                  return null;
                },
                onChanged: (String value) {
                  //print(value);
                },
                onSaved: (val) {
                  setState(() => _user.email = val);
                },
                cursorColor: LightColor.main,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.email,
                        color: LightColor.main,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ce champ est requis';
                  } else if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
                onChanged: (String value) {
                  validatePassword = value;
                },
                onSaved: (val) {
                  setState(() => _user.password = val);
                },
                cursorColor: LightColor.main,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Mot de passe",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: LightColor.main,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ce champ est requis';
                  } else if (value != validatePassword) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
                onChanged: (String value) {},
                cursorColor: LightColor.main,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Répetez le mot de passe",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: LightColor.main,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: LightColor.main),
                  child: FlatButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_reg.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        _reg.currentState.save();
                        _email = _user.email;
                        _password = _user.password;
                        // print(_user.firstName);
                        // print(_user.lastName);
                        // print(_user.email);
                        // print(_user.password);
                        validateAndSubmit();
                      }
                    },
                    child: Text(
                      "Inscription",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ))),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/fb.png',
                width: SizeConfig.screenWidth * 0.1,
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset(
                'assets/google.png',
                width: SizeConfig.screenWidth * 0.1,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Vous êtes déjà inscrit ?",
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.safeBlockVertical * 2.5,
                fontWeight: FontWeight.normal),
          ),
          InkWell(
            child: Text("Connexion",
                style: TextStyle(
                    color: LightColor.main,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.safeBlockVertical * 2.5)),
            onTap: () {
              setState(() {
                item = 1;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _passwordForgot() {
    return Form(
        key: _reset,
        child: Column(
          children: <Widget>[
            Text(
              "Récupérez votre mot de passe",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockVertical * 2.5,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ce champ est requis';
                    } else if (EmailValidator.validate(value) == false) {
                      return 'Entrez un email valide';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    //print(value);
                  },
                  onSaved: (val) {
                    setState(() => _user.email = val);
                  },
                  cursorColor: LightColor.main,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.email,
                          color: LightColor.main,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Un mail de récupération va vous être envoyé",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockVertical * 2.5,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: LightColor.main),
                    child: FlatButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_reset.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          _reset.currentState.save();
                          _email = _user.email;
                          validateAndSubmit();
                        }
                      },
                      child: Text(
                        "Récupérer mon mot de passe",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ))),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Vous êtes déjà inscrit ?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockVertical * 2.5,
                  fontWeight: FontWeight.normal),
            ),
            InkWell(
              child: Text("Connexion",
                  style: TextStyle(
                      color: LightColor.main,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.safeBlockVertical * 2.5)),
              onTap: () {
                setState(() {
                  item = 1;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _itemSelect() {
    if (item == 1 && _isLoading == false) {
      return _login();
    } else if (item == 2 && _isLoading == false)
      return _register();
    else if (item == 3 && _isLoading == false)
      return _passwordForgot();
    else if (_isLoading)
      return Container(
          margin: const EdgeInsets.only(top: 50.0),
          child: SpinKitRotatingCircle(
            color: LightColor.main,
            size: 50.0,
          ));
    else
      return _login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (ctx) => ListView(children: <Widget>[
            _header(context),
            _title(),
            SizedBox(
              height: 20,
            ),
            _itemSelect(),
          ]),
        ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
