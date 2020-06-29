import 'package:flutter/material.dart';
import 'package:cookit/src/config/SizeConfig.dart';
import 'package:cookit/src/model/data.dart';
import 'package:cookit/src/model/recipe.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:cookit/src/themes/theme.dart';
import 'package:cookit/src/wigets/title_text.dart';
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
     SizeConfig().init(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: model.id);
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
       
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               // SizedBox(height: 15),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: SizeConfig.safeBlockVertical*8,
                      backgroundColor: LightColor.main,
                      child: CircleAvatar(
                        radius: SizeConfig.safeBlockVertical*7.5,
                        backgroundImage: NetworkImage(model.image),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 5),
                AutoSizeText(
                  model.name,
                  style: TextStyle(fontSize: SizeConfig.safeBlockVertical*3, fontWeight: FontWeight.w800),
                  maxLines: 2,
                  textAlign: TextAlign.center
                ),
                TitleText(
                  text:
                      "Prêt en " + model.readyInMinutes.toString() + " minutes",
                  fontSize: SizeConfig.safeBlockVertical*2.5,
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
