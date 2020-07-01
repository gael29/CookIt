import 'package:cookit/src/config/SizeConfig.dart';
import 'package:cookit/src/services/authentication.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
    ProfilePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  
Widget _header(BuildContext context) {
  return Stack(
        children: <Widget>[
          Container(
             height: SizeConfig.screenHeight * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [LightColor.main, LightColor.green2]),
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
          _buildHeader(context),
   
        ],
      );
}

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
      height: 250.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70.0,),
                  Text("Gaël Lann", style: Theme.of(context).textTheme.title,),
                  SizedBox(height: 5.0,),
                  Text("UI/UX designer | Foodie | Kathmandu"),
                  SizedBox(height: 16.0,),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text("302",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text("Favoris".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0) ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("10",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text("Plans".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0) ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("120",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text("Amis".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0) ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(
                'assets/pp.jpg',
              ),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        _header(context),
                Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: LightColor.main),
                  child: FlatButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, otherwise false.  
                      await widget.auth.signOut(); 
                      Navigator.of(context).popAndPushNamed('/auth');
                    },
                    child: Text(
                      "Déconnexion",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ))),
      
      ]),
    );
  }
}