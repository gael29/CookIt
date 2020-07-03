import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookit/src/config/SizeConfig.dart';
import 'package:cookit/src/model/user.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatefulWidget {
  final String userId;
  AddFriendPage({Key key, @required this.userId}) : super(key: key);
  final firestoreInstance = Firestore.instance;

  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
        
  bool isLoading = true;
  List<User> userList = List<User>();
  final List<Map> schoolLists = [
    {
      "name": "Edgewick Scchol",
      "location": "572 Statan NY, 12483",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "Xaviers International",
      "location": "234 Road Kathmandu, Nepal",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "Kinder Garden",
      "location": "572 Statan NY, 12483",
      "type": "Play Group School",
      "logoText":
          "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
    },
    {
      "name": "WilingTon Cambridge",
      "location": "Kasai Pantan NY, 12483",
      "type": "Lower Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
    {
      "name": "Fredik Panlon",
      "location": "572 Statan NY, 12483",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "Whitehouse International",
      "location": "234 Road Kathmandu, Nepal",
      "type": "Higher Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "Haward Play",
      "location": "572 Statan NY, 12483",
      "type": "Play Group School",
      "logoText":
          "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
    },
    {
      "name": "Campare Handeson",
      "location": "Kasai Pantan NY, 12483",
      "type": "Lower Secondary School",
      "logoText":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
  ];

       @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

   Future _getUserInfo() async {
    widget.firestoreInstance
        .collection("users")
      .getDocuments()
          .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((users) {
           final _user = User();
        _user.id = users.documentID;
        _user.firstName = users.data["Firstname"];
        _user.lastName = users.data["Lastname"];
        _user.email = users.data["Email"];
        _user.image = users.data["Image"];
        _user.fav = users.data["Fav"];
        _user.plan = users.data["Plan"];
     setState(() {
       if(_user.id!=widget.userId)
       userList.add(_user);
     });
      
    });

    //print(userList);

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,                        
          child: Stack(
            children: <Widget>[
              Container(
                
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.25),
                margin: EdgeInsets.only(bottom: 40),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(context, index);
                    }),
              ),
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient:
                LinearGradient(colors: [LightColor.main, LightColor.green2]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/lime.png',
            width: SizeConfig.safeBlockHorizontal*15,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 110,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: TextField(
                          // controller: TextEditingController(text: locations[0]),
                          cursorColor: Theme.of(context).primaryColor,
                          style: dropdownMenuItem,
                          decoration: InputDecoration(
                              hintText: "Rechercher un ami",
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 16),
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Icon(Icons.search),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                  ],
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
          ),
        ),
      ],)

    );
  }


  Widget buildList(BuildContext context, int index) {
    return InkWell(    
       onTap: () {                          
        Navigator.of(context).pushNamed('/friend', arguments: userList[index].id);
        },                      
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.2,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: LightColor.main),
              image: DecorationImage(
                  image: NetworkImage(userList[index].image),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userList[index].firstName+" "+userList[index].lastName,
                  style: TextStyle(
                      color: LightColor.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),
               
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: LightColor.main,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                      if(userList[index].fav.length>0)
                    Text(userList[index].fav.length.toString()+" favoris",
                        style: TextStyle(
                             fontSize: 13, letterSpacing: .3))
                             else
                             Text("Pas de favoris",
                        style: TextStyle(
                             fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_dining,
                      color: LightColor.main,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                     if(userList[index].fav.length>0)
                    Text(userList[index].plan.length.toString()+" plans",
                        style: TextStyle(
                             fontSize: 13, letterSpacing: .3))
                             else
                             Text("Pas de plan",
                        style: TextStyle(
                             fontSize: 13, letterSpacing: .3))
                  ],
                ),
                 SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      color: LightColor.main,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if(userList[index].fav.length>0)
                    Text(userList[index].plan.length.toString()+" amis",
                        style: TextStyle(
                             fontSize: 13, letterSpacing: .3))
                             else 
                             Text("Pas d'amis",
                        style: TextStyle(
                             fontSize: 13, letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
        )
    );
  }
}