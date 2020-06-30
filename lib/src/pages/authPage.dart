import 'package:cookit/src/config/SizeConfig.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

var item = 1;

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
              gradient:
                  LinearGradient(colors: [LightColor.main, LightColor.green2])),
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
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
              child: Text(
                "Connexion",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('/profile');
              },
            ),
          )),
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
              fontSize: SizeConfig.safeBlockVertical * 2.5)
              ),
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
  );
}


Widget _register() {
  return Column(
    children: <Widget>[
       Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
              child: Text(
                "Inscription",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              onPressed: () {
                 Navigator.of(context).popAndPushNamed('/profile');
             
              },
            ),
          )),
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
              fontSize: SizeConfig.safeBlockVertical * 2.5)
              ),
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
  );
}

Widget _password() {
  return Column(
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
          child: TextField(
            onChanged: (String value) {},
            cursorColor: LightColor.main,
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
              child: Text(
                "Récupérer mon mot de passe",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              onPressed: () {},
            ),
          )),
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
    child:
      Text("Connexion",
          style: TextStyle(
              color: LightColor.main,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.safeBlockVertical * 2.5)
              ),
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
  );
}

  Widget _itemSelect() {
    if (item==1) {
      return _login();
    } else if (item==2)
       return _register();
    else if (item==3)
      return _password();
    else
      return _login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        _header(context),
         SizedBox(
          height: 20,
        ),
        _itemSelect(),
      ]),
    );
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
