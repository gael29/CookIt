import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/SizeConfig.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/pages/home_page.dart';
import 'package:flutter_ecommerce_app/src/pages/favPage.dart';
import 'package:flutter_ecommerce_app/src/pages/shoppingListPage.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:flutter_ecommerce_app/src/wigets/prduct_icon.dart';
import 'package:flutter_ecommerce_app/src/wigets/product_card.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';

import 'listPage.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isHomePageSelected)
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleText(
                      text: 'Nos',
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontWeight: FontWeight.w400,
                    ),
                    TitleText(
                      text: 'Recettes',
                      fontSize: SizeConfig.safeBlockHorizontal*6,
                      fontWeight: FontWeight.w700,
                    )
                  ]),
            if (isFavSelected)
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleText(
                      text: 'Vos',
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontWeight: FontWeight.w400,
                    ),
                    TitleText(
                      text: 'Favoris',
                      fontSize: SizeConfig.safeBlockHorizontal*6,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: LightColor.main,
                          size: 40,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TitleText(
                            text: 'Retrouvez la liste de vos coups de coeur',
                            fontSize: SizeConfig.safeBlockHorizontal*5,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30)
                  ]),
            if (isRecipeSelected)
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleText(
                      text: 'Vos',
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontWeight: FontWeight.w400,
                    ),
                    TitleText(
                      text: 'Recettes prévues',
                      fontSize: SizeConfig.safeBlockHorizontal*6,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.local_dining,
                          color: LightColor.main,
                          size: 40,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TitleText(
                            text: 'Retrouvez la liste de vos recettes à faire.\nVotre liste de course sera automatiquement générée.',
                            fontSize: SizeConfig.safeBlockHorizontal*5,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30)
                  ]),
            if (isListSelected)
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleText(
                      text: 'Votre',
                      fontSize: SizeConfig.safeBlockHorizontal*7,
                      fontWeight: FontWeight.w400,
                    ),
                    TitleText(
                      text: 'Liste de course',
                      fontSize: SizeConfig.safeBlockHorizontal*6,
                      fontWeight: FontWeight.w700,
                    )
                  ]),
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
    } else if (index == 1) {
      setState(() {
        isHomePageSelected = false;
        isRecipeSelected = false;
        isListSelected = false;
        isFavSelected = true;
      });
    } else if (index == 2) {
      setState(() {
        isHomePageSelected = false;
        isRecipeSelected = true;
        isListSelected = false;
        isFavSelected = false;
      });
    } else if (index == 3) {
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
    } else if (isFavSelected)
      return Align(
        alignment: Alignment.topCenter,
        child: FavPage(),
      );
    else if (isRecipeSelected)
      return Align(
        alignment: Alignment.topCenter,
        child: ListPage(),
      );
      else if (isListSelected)
      return Align(
        alignment: Alignment.topCenter,
        child: ShoppingListPage(),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: MyHomePage(),
      );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                        child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            switchInCurve: Curves.easeInToLinear,
                            switchOutCurve: Curves.easeOutBack,
                            child: _displayPage())),
                            SizedBox(height: 40),

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
