import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookit/src/config/SizeConfig.dart';
import 'package:cookit/src/model/user.dart';
import 'package:cookit/src/services/authentication.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:cookit/src/wigets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FriendPage extends StatefulWidget {
  final String friendId;
  FriendPage({Key key, @required this.friendId}) : super(key: key);

  final firestoreInstance = Firestore.instance;
  final BaseAuth auth = new Auth();

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final _friend = User();
  final _user = User();
  List _friendList = List();
  bool isLoading = true;
  bool isFriend = false;
  var friendIndex;

  @override
  void initState() {
    super.initState();
    _getFriendInfo();
    // _getUserInfo();
    // _getFriendList();
  }

  Future _getFriendInfo() async {
    await widget.firestoreInstance
        .collection("users")
        .document(widget.friendId)
        .get()
        .then((user) {
      //print(user.data["Fav"]);

      setState(() {
        _friend.id = widget.friendId;
        _friend.firstName = user.data["Firstname"];
        _friend.lastName = user.data["Lastname"];
        _friend.email = user.data["Email"];
        _friend.image = user.data["Image"];
        _friend.fav = user.data["Fav"];
        _friend.plan = user.data["Plan"];
        _friend.friends = user.data["Friends"];
        //print(_user.plan[1]["name"]);
      });
    });

    await widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _user.id = user?.uid;
        }
      });
    });

    await widget.firestoreInstance
        .collection("users")
        .document(_user.id)
        .get()
        .then((user) {
      //print(user.data["Fav"]);
      _user.friends = user.data["Friends"];
      Future.forEach(_user.friends, (friendList) async {
        if (friendList["Id"] == _friend.id) {
          setState(() {
            isFriend = true;
            // friendIndex = i;
          });
        }
      });
      setState(() {
         isLoading = false;
      });
    });
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: SizeConfig.screenHeight * 0.3,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [LightColor.main, LightColor.green2]),
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
        if (isFriend)
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: CircleAvatar(
                radius: SizeConfig.safeBlockVertical * 4,
                backgroundColor: LightColor.background,
                child: IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: LightColor.main,
                    onPressed: () {
                     _user.friends.removeWhere((item) => item['Id'] == _friend.id);
                                  widget.firestoreInstance.collection("users").document(_user.id).updateData({
                        "Friends":  _user.friends
                      }).then((_) {
                      setState(() {
                        isFriend = !isFriend;
                      });
                      });
                    }),
              ),
            ),
          ),
          if (!isFriend)
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: CircleAvatar(
                radius: SizeConfig.safeBlockVertical * 4,
                backgroundColor: LightColor.background,
                child: IconButton(
                    icon: Icon(Icons.person_add),
                    color: LightColor.main,
                    onPressed: () {
                      _user.friends.add(_friend.toJson());
                                  widget.firestoreInstance.collection("users").document(_user.id).updateData({
                        "Friends":  _user.friends
                      }).then((_) {
                      setState(() {
                        isFriend = !isFriend;
                      });
                      });
                    }),
              ),
            ),
          ),
        _buildHeader(context),
      ],
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.1),
      height: 250.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    _friend.firstName + " " + _friend.lastName,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              _friend.fav.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Favoris".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              _friend.plan.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Plans".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                             _friend.friends.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Amis".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
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
                    radius: 50.0, backgroundImage: NetworkImage(_friend.image)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _friendSlide() {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TitleText(
                text: 'Amis',
                fontSize: SizeConfig.safeBlockHorizontal * 5,
                fontWeight: FontWeight.w700,
              ),
            ]),
      ),
      if (_friend.friends.length > 0)
        CarouselSlider(
          options: CarouselOptions(
            height: 100,
            autoPlay: false,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: _friend.friends
              .map((item) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/friend', arguments: item["Id"]);
                  },
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: SizeConfig.safeBlockVertical * 6,
                            backgroundColor: LightColor.main,
                            child: CircleAvatar(
                              radius: SizeConfig.safeBlockVertical * 5.5,
                              backgroundImage: NetworkImage(item["Image"]),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  )))
              .toList(),
        )
      else
        Column(children: <Widget>[
          SizedBox(height: 10),
          Text(_friend.firstName + " n'a pas encore d'amis",
              style: TextStyle(
                color: LightColor.main,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ))
        ])
    ]);
  }

  Widget _favSlide() {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
        child: Row(children: <Widget>[
          TitleText(
            text: 'Favoris',
            fontSize: SizeConfig.safeBlockHorizontal * 5,
            fontWeight: FontWeight.w700,
          ),
        ]),
      ),
      if (_friend.fav.length > 0)
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: _friend.fav
              .map((item) => InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/detail', arguments: item["id"]);
                  },
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(item["image"],
                                  fit: BoxFit.cover, width: 1000.0),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    item["name"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  )))
              .toList(),
        )
      else
        Column(children: <Widget>[
          SizedBox(height: 10),
          Text(_friend.firstName + " n'a pas encore de favoris",
              style: TextStyle(
                color: LightColor.main,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ))
        ])
    ]);
  }

  Widget _planSlide() {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
        child: Row(children: <Widget>[
          TitleText(
            text: 'Plans',
            fontSize: SizeConfig.safeBlockHorizontal * 5,
            fontWeight: FontWeight.w700,
          ),
        ]),
      ),
      if (_friend.plan.length > 0)
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: _friend.plan
              .map((item) => InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/detail', arguments: item["id"]);
                  },
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(item["image"],
                                  fit: BoxFit.cover, width: 1000.0),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    item["name"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  )))
              .toList(),
        )
      else
        Column(children: <Widget>[
          SizedBox(height: 10),
          Text(_friend.firstName + " n'a pas encore de recette prévue",
              style: TextStyle(
                color: LightColor.main,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ))
        ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: SpinKitRotatingCircle(
                color: LightColor.main,
                size: 50.0,
              ))
          : ListView(children: <Widget>[
              _header(context),
              _friendSlide(),
              _favSlide(),
              _planSlide(),
              SizedBox(height: 50),
            ]),
    );
  }
}
