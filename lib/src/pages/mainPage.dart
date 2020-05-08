import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/pages/home_page.dart';
import 'package:flutter_ecommerce_app/src/pages/favPage.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:flutter_ecommerce_app/src/wigets/prduct_icon.dart';
import 'package:flutter_ecommerce_app/src/wigets/product_card.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  bool isRecipeSelected = false;
  bool isListSelected = false;
  bool isFavSelected = false;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: Image.asset("assets/user.png"),
            ),
          )
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (isHomePageSelected)
                TitleText(
                  text: 'Nos',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                if (isHomePageSelected)
                TitleText(
                  text: 'Recettes',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
                 if (isRecipeSelected)
                TitleText(
                  text: 'Recettes',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                if (isRecipeSelected)
                TitleText(
                  text: 'ajoutées',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
                 if (isListSelected)
                TitleText(
                  text: 'Votre liste',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                if (isListSelected)
                TitleText(
                  text: 'de courses',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
                 if (isFavSelected)
                TitleText(
                  text: 'Vos',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                if (isFavSelected)
                TitleText(
                  text: 'Favoris',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            Spacer(),
            
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0) {
      setState(() {
        isHomePageSelected = true;
        isRecipeSelected = false;
        isListSelected = false;
        isFavSelected = false;
      });
    } 
    
    else if (index == 1) {
      setState(() {
        isHomePageSelected = false;
        isRecipeSelected = false;
        isListSelected = false;
        isFavSelected = true;
      });
    }

     else if (index == 2) {
      setState(() {
        isHomePageSelected = false;
        isRecipeSelected = true;
        isListSelected = false;
        isFavSelected = false;
      });
    }

     else if (index == 3) {
      setState(() {
        isHomePageSelected = false;
        isRecipeSelected = false;
        isListSelected = true;
        isFavSelected = false;
      });
    }
  }

  Widget _displayPage() {
  if (isHomePageSelected) {
    return MyHomePage();
  }
  else if (isFavSelected)
  return Align(
                              alignment: Alignment.topCenter,
                              child:FavPage(),
                            );
  else return Align(
                              alignment: Alignment.topCenter,
                              child:FavPage(),
                            );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(),
                    _title(),
                    Expanded(
                        child:AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeInToLinear,
                          switchOutCurve: Curves.easeOutBack,
                          child:  _displayPage()
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: CustomBottomNavigationBar(
                  onIconPresedCallback: onBottomIconPressed,
                ))
          ],
        ),
      ),
    );
  }
}
