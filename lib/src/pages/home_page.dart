import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/recipe.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:flutter_ecommerce_app/src/wigets/prduct_icon.dart';
import 'package:flutter_ecommerce_app/src/wigets/product_card.dart';
import 'package:flutter_ecommerce_app/src/wigets/recipe_card.dart';
import 'package:flutter_ecommerce_app/src/wigets/search.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_ecommerce_app/src/config/SizeConfig.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 String research = "null";
 bool list = false;
 String url = "null";
 List<Recipe> rList = List();
  var isLoading = false;

 callback(word) {
        setState(() {
          rList = null;
          research = word;
          list = true;
          url = "https://api.spoonacular.com/recipes/search?apiKey=65474d667d2146c088471d7329e0d3db&query="+research+"&number=30";
          url = url.split(" ").join("%20");
          print(url);
          _fetchData(url);
          
        });
      }

 _fetchData(String jsonUrl) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(jsonUrl);

    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType); // _InternalLinkedHashMap<String, dynamic>

      rList = (json.decode(response.body)['results'] as List)
      .map((data) => Recipe.fromJson(data))
      .toList();

      setState(() {
        isLoading = false;
        print(rList);
      });
    } else {
      throw Exception('Failed to load');
    }
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

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: AppData.categoryList
              .map((category) => ProducIcon(
                    model: category,
                  ))
              .toList()),
    );
  }

  Widget _recipeWidget() {
    return Visibility(
      visible: list ? true : false,
      child : isLoading
            ?  Container(
    margin: const EdgeInsets.only(top: 50.0),
      child: SpinKitRotatingCircle(
    
  color: LightColor.main,
  size: 50.0,
))
            : Container(
  // margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullHeight(context)*0.6,
      child: 
      GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 4/3,
              mainAxisSpacing: 30,
              crossAxisSpacing: 20),
         padding: EdgeInsets.only(left: 20 ,right: 20, bottom:SizeConfig.safeBlockVertical*30),
          scrollDirection: Axis.vertical,
          children:  rList
              .map((recipe) => RecipeCard(
                    recipe: recipe,
                  ))
              .toList()
              ),
    ));
  }

   Widget _search(abc, callback) {
     return Container(
      margin: AppTheme.padding,
      child: Search(research, callback),
    );
  }

  Widget _background() {
     return  Visibility(
      visible: list ? false : true,
      child : Container(
       alignment: Alignment.center,
      margin: AppTheme.padding,
      child: Column(
            children: <Widget>[
              Image.asset(
                'assets/recipe.png',
                height: SizeConfig.safeBlockVertical*40,
    width: SizeConfig.safeBlockHorizontal*40,
              ),
              TitleText(
                  text: "Découvrez de nouvelles recettes !", 
                  fontSize: 20,
                  color: LightColor.main,
                )
            ],
          ),
      ),
     );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _search(research, callback),
          _background(),
          Expanded(
      child: 
          _recipeWidget()
          ),
          
         // _test(),
          ],
      
      );
  }
}
