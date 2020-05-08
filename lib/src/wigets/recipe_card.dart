import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/recipe.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  RecipeCard({Key key, this.recipe}) : super(key: key);

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  Recipe model;
  @override
  void initState() {
    model = widget.recipe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: model.id);
        setState(() {
          // model.isSelected = !model.isSelected;
          //   AppData.productList.forEach((x) {
          //     if (x.id == model.id && x.name == model.name) {
          //       return;
          //     }
          //     x.isSelected = false;
          //   });
          //   var m = AppData.productList
          //       .firstWhere((x) => x.id == model.id && x.name == model.name);
          //   m.isSelected = !m.isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
          ],
        ),
        //    margin: EdgeInsets.symmetric(vertical: !model.isSelected ? 20 : 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                    icon: Icon(
                      model.isLiked ? Icons.favorite : Icons.favorite_border,
                      color:
                          model.isLiked ? LightColor.red : LightColor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        model.isLiked = !model.isLiked;
                      });
                    })),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 15),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 85,
                      backgroundColor: LightColor.main,
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage: NetworkImage(model.image),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 5),
                AutoSizeText(
                  model.name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
                  maxLines: 2,
                  textAlign: TextAlign.center
                ),
                TitleText(
                  text:
                      "Prêt en " + model.readyInMinutes.toString() + " minutes",
                  fontSize: 20,
                  color: LightColor.main,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
