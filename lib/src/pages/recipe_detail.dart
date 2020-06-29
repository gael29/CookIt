import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cookit/src/config/SizeConfig.dart';
import 'package:cookit/src/database/database.dart';
import 'package:cookit/src/model/category.dart';
import 'package:cookit/src/model/data.dart';
import 'package:cookit/src/model/detail.dart';
import 'package:cookit/src/model/recipe.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:cookit/src/themes/theme.dart';
import 'package:cookit/src/wigets/prduct_icon.dart';
import 'package:cookit/src/wigets/title_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:cookit/src/extensions/string_extension.dart';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;
  RecipeDetailPage({Key key, @required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();

  //String infoUrl ="https://api.spoonacular.com/recipes/"+recipeId+"/information?apiKey=65474d667d2146c088471d7329e0d3db";

}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  String infoUrl;
  Detail recipeDetail = new Detail();
  Recipe recipe = new Recipe();
  var isDetailLoading = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      infoUrl = "https://api.spoonacular.com/recipes/" +
          widget.recipeId.toString() +
          "/information?apiKey=65474d667d2146c088471d7329e0d3db";
      print(infoUrl);
      _fetchDetail(infoUrl);
      // recipe = DBProvider.db.getFav.(widget.recipeId);
    });
  }

  _fetchDetail(String jsonUrl) async {
    setState(() {
      isDetailLoading = true;
    });

    final response = await http.get(jsonUrl);

    if (response.statusCode == 200) {
      print(json
          .decode(response.body)
          .runtimeType); // _InternalLinkedHashMap<String, dynamic>

      recipeDetail = Detail.fromJson(jsonDecode(response.body));

      setState(() {
        isDetailLoading = false;
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;

  Widget _recipeImage() {
    return Material(
      child: AnimatedBuilder(
        builder: (context, child) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: animation.value,
            child: child,
          );
        },
        animation: animation,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            TitleText(
              text: "",
              fontSize: 160,
              color: LightColor.lightGrey,
            ),
            Image.network(recipeDetail.image),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: CircleAvatar(
                  radius: SizeConfig.safeBlockVertical*4,
                  backgroundColor: LightColor.main,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: LightColor.background,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: LightColor.main,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(recipeDetail.isliked
                                ? Icons.favorite
                                : Icons.favorite_border),
                            color: recipeDetail.isliked
                                ? LightColor.red
                                : LightColor.background,
                            onPressed: () {
                              if (!recipeDetail.isliked) {
                                Recipe fav = new Recipe();
                                fav.RecipeFav(
                                    recipeDetail.id,
                                    recipeDetail.name,
                                    recipeDetail.readyInMinutes,
                                    recipeDetail.image,
                                    recipeDetail.isliked,
                                    recipeDetail.isOnList);

                                DBProvider.db.newFav(fav);
                                setState(() {
                                  recipeDetail.setLike();
                                });
                              } else {
                                DBProvider.db.deleteFav(recipeDetail.id);
                                setState(() {
                                  recipeDetail.setLike();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: LightColor.main,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.shopping_cart),
                            color: recipeDetail.isOnList
                                ? LightColor.red
                                : LightColor.background,
                            onPressed: () {
                              setState(() {
                                if (!recipeDetail.isOnList) {
                                Recipe fav = new Recipe();
                                fav.RecipeList(
                                    recipeDetail.id,
                                    recipeDetail.name,
                                    recipeDetail.readyInMinutes,
                                    recipeDetail.image,
                                    recipeDetail.isliked,
                                    recipeDetail.isOnList,
                                    recipeDetail.servings);
                                   

                                DBProvider.db.newList(fav);
                              for (var ing in recipeDetail.ingredients) {
                                ing.recipeId=recipeDetail.id;
                                DBProvider.db.newIngredient(ing);
                              }
                                setState(() {
                                  recipeDetail.setList();
                                });
                              } else {
                                DBProvider.db.deleteList(recipeDetail.id);
                                DBProvider.db.deleteIngredient(recipeDetail.id);
                                setState(() {
                                  recipeDetail.setList();
                                });
                              }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .9,
      initialChildSize: .7,
      minChildSize: .7,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(recipeDetail.name,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: 20,
                ),
                //   _availableSize(),
          
                //     _availableColor(),
                _header(),
                SizedBox(
                  height: 20,
                ),
                _ingredients(),
                SizedBox(
                  height: 20,
                ),
                _description()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _checkLike() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    return new FutureBuilder<List<Recipe>>(
        future: DBProvider.db.getFav(
            widget.recipeId), //This is the method that returns your Future
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              recipeDetail.isliked = true;
            } else {
              recipeDetail.isliked = false;
            }
          }
          return Scaffold();
        });
  }

  Widget _checkList() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    return new FutureBuilder<List<Recipe>>(
        future: DBProvider.db.getList(
            widget.recipeId), //This is the method that returns your Future
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              recipeDetail.isOnList = true;
              int serv = recipeDetail.servings;
              recipeDetail.servings = snapshot.data[0].servings;
              recipeDetail.setServings(serv, recipeDetail.servings);
            } else {
              recipeDetail.isOnList = false;
            }
          }
          return Scaffold();
        });
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (recipeDetail.preparationMinutes != null)
              Column(children: [
                Icon(
                  Icons.timer,
                  color: LightColor.main,
                  size: SizeConfig.safeBlockVertical*7,
                ),
                TitleText(
                  text: "Preparation :",
                      fontSize: SizeConfig.safeBlockVertical*2.5,
                ),
                 TitleText(
                  text: recipeDetail.preparationMinutes.toString()+" min",
                      fontSize: SizeConfig.safeBlockVertical*2.5,
                ),
              ]),
            if (recipeDetail.preparationMinutes != null) SizedBox(width: 20),
            if (recipeDetail.cookingMinutes != null)
              Column(children: [
                Icon(
                  Icons.hourglass_empty,
                  color: LightColor.main,
                  size: SizeConfig.safeBlockVertical*7,
                ),
                TitleText(
                  text: "Cuisson :",
                   fontSize: SizeConfig.safeBlockVertical*2.5,
                ),
                TitleText(
                  text: recipeDetail.cookingMinutes.toString() +
                      " min",
                       fontSize: SizeConfig.safeBlockVertical*2.5,
                )
              ]),
            if (recipeDetail.cookingMinutes == null &&
                recipeDetail.preparationMinutes == null &&
                recipeDetail.readyInMinutes != null)
              Column(children: [
                Icon(
                  Icons.timer,
                  color: LightColor.main,
                  size: 50,
                ),
                TitleText(
                  text: "Prêt en :",
                ),
                TitleText(
                  text: recipeDetail.readyInMinutes.toString() + " min",
                ),
              ]),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (recipeDetail.vegan)
              Column(children: [
                Icon(
                  Icons.spa,
                  color: LightColor.main,
                  size: 30,
                ),
                TitleText(
                  text: "Vegan",
                  fontSize: SizeConfig.safeBlockVertical*2.5
                ),
              ]),
            // SizedBox(width: 20),
            if (recipeDetail.vegetarian)
              Column(children: [
                Icon(
                  Icons.nature,
                  color: LightColor.main,
                  size: 30,
                ),
                TitleText(
                  text: "Végé",
                  fontSize: SizeConfig.safeBlockVertical*2.5
                ),
              ]),
            //  SizedBox(width: 20),
            if (recipeDetail.veryHealthy)
              Column(children: [
                Icon(
                  Icons.accessibility_new,
                  color: LightColor.main,
                  size: 30,
                ),
                TitleText(
                  text: "Healthy",
                  fontSize: SizeConfig.safeBlockVertical*2.5
                ),
              ]),
            //   SizedBox(width: 20),
            if (recipeDetail.glutenFree)
              Column(children: [
                Icon(
                  Icons.not_interested,
                  color: LightColor.main,
                  size: 30,
                ),
                TitleText(
                  text: "Sans gluten",
                  fontSize: SizeConfig.safeBlockVertical*2.5
                ),
              ]),
          ],
        ),
      ],
    );
  }

  Widget _ingredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Ingredients",
          fontSize: 20,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Modifier nb personnes
            IconButton(
              icon: Icon(Icons.remove_circle_outline, size: SizeConfig.safeBlockVertical*7),
              color: LightColor.main,
              onPressed: () {
                setState(() {
                  recipeDetail.removeServings();
                  
                });
                if(recipeDetail.isOnList){
                  DBProvider.db.updateServingsList(recipeDetail.id,recipeDetail.servings);
                  for (var ing in recipeDetail.ingredients) {
                                DBProvider.db.updateShoppingListAmount(recipeDetail.id, ing.amount, ing.name);
                              }
                  }
              },
            ),

            Column(children: [
              Icon(
                Icons.people,
                color: LightColor.main,
                size: SizeConfig.safeBlockVertical*7,
              ),
              TitleText(
                text: recipeDetail.servings.toString(),
              ),
            ]),
            IconButton(
              icon: Icon(Icons.add_circle_outline, size: SizeConfig.safeBlockVertical*7),
              color: LightColor.main,
              onPressed: () {
                
                setState(() {
                  recipeDetail.addServings();
                  
                });
                
                if(recipeDetail.isOnList){
                  DBProvider.db.updateServingsList(recipeDetail.id,recipeDetail.servings);
                   for (var ing in recipeDetail.ingredients) {
                               DBProvider.db.updateShoppingListAmount(recipeDetail.id, ing.amount, ing.name);
                              }
                  }
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        for (var item in recipeDetail.ingredients)
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: NetworkImage(item.image),
                height: 40,
                width: 40,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(item.name.capitalize() + " ",
                    style: GoogleFonts.muli(fontSize: 17)),
              ),
              TitleText(
                text: "x " +
                    item.amount
                        .toStringAsFixed(2)
                        .toString()
                        .replaceAll(RegExp(r'.00'), ''),
                color: LightColor.main,
              ),
              TitleText(
                text: " " + item.unit,
                color: LightColor.main,
              ),
            ],
          ),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Instruction",
          fontSize: 20,
        ),
        for (var ind in recipeDetail.analizedInstructions)
          for (var ins in ind.instructions)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                TitleText(
                  text: "Etape n°" + ins.number.toString(),
                  color: LightColor.main,
                ),
                Text(ins.step, style: GoogleFonts.muli(fontSize: 17)),
              ],
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //floatingActionButton: _floatingButton(),
      body: SafeArea(
        child: isDetailLoading
            ? Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: SpinKitRotatingCircle(
                  color: LightColor.main,
                  size: 50.0,
                ))
            : Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Stack(
                  children: <Widget>[
                    _checkLike(),
                    _checkList(),
                    Column(
                      children: <Widget>[
                        //   _appBar(),
                        _recipeImage(),
                        // _categoryWidget(),
                      ],
                    ),
                    _detailWidget(),
                  ],
                ),
              ),
      ),
    );
  }

  // Widget _appBar() {
  //   return Container(
  //     padding: AppTheme.padding,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         InkWell(
  //           onTap: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: _icon(Icons.arrow_back_ios,
  //               color: Colors.black54, size: 15, padding: 12, isOutLine: true),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             setState(() {
  //               isLiked = !isLiked;
  //             });
  //           },
  //           child: _icon(isLiked ? Icons.favorite : Icons.favorite_border,
  //               color: isLiked ? LightColor.red : LightColor.lightGrey,
  //               size: 15,
  //               padding: 12,
  //               isOutLine: false),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _icon(IconData icon,
  //     {Color color = LightColor.iconColor,
  //     double size = 20,
  //     double padding = 10,
  //     bool isOutLine = false}) {
  //   return Container(
  //     height: 40,
  //     width: 40,
  //     padding: EdgeInsets.all(padding),
  //     // margin: EdgeInsets.all(padding),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //           color: LightColor.iconColor,
  //           style: isOutLine ? BorderStyle.solid : BorderStyle.none),
  //       borderRadius: BorderRadius.all(Radius.circular(13)),
  //       color:
  //           isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Color(0xfff8f8f8),
  //             blurRadius: 5,
  //             spreadRadius: 10,
  //             offset: Offset(5, 5)),
  //       ],
  //     ),
  //     child: Icon(icon, color: color, size: size),
  //   );
  // }

  //  Stack(
  //                 alignment: Alignment.center,
  //                 children: <Widget>[
  //                   CircleAvatar(
  //                     radius: 85,
  //                     backgroundColor: LightColor.main,
  //                     child: CircleAvatar(
  //                       radius: 80.0,
  //                       backgroundImage: NetworkImage(model.image),
  //                       backgroundColor: Colors.transparent,
  //                     ),
  //                   )
  //                 ],
  //               ),

  // Widget _categoryWidget() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 0),
  //     width: AppTheme.fullWidth(context),
  //     height: 80,
  //     child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children:
  //             AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()),
  //   );
  // }

  // Widget _thumbnail(String image) {
  //   return AnimatedBuilder(
  //       animation: animation,
  //       //  builder: null,
  //       builder: (context, child) => AnimatedOpacity(
  //             opacity: animation.value,
  //             duration: Duration(milliseconds: 500),
  //             child: child,
  //           ),
  //       child: Container(
  //         height: 40,
  //         width: 50,
  //         margin: EdgeInsets.symmetric(horizontal: 10),
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             color: LightColor.grey,
  //           ),
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(13),
  //           ),
  //           // color: Theme.of(context).backgroundColor,
  //         ),
  //         child: Image.asset(image),
  //       ));
  // }

  // Widget _availableSize() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       TitleText(
  //         text: "Available Size",
  //         fontSize: 14,
  //       ),
  //       SizedBox(height: 20),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           _sizeWidget("US 6"),
  //           _sizeWidget("US 7", isSelected: true),
  //           _sizeWidget("US 8"),
  //           _sizeWidget("US 9"),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Widget _sizeWidget(String text,
  //     {Color color = LightColor.iconColor, bool isSelected = false}) {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //           color: LightColor.iconColor,
  //           style: !isSelected ? BorderStyle.solid : BorderStyle.none),
  //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //       color:
  //           isSelected ? LightColor.main : Theme.of(context).backgroundColor,
  //     ),
  //     child: TitleText(
  //       text: text,
  //       fontSize: 16,
  //       color: isSelected ? LightColor.background : LightColor.titleTextColor,
  //     ),
  //   );
  // }

  // Widget _availableColor() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       TitleText(
  //         text: "Available Size",
  //         fontSize: 14,
  //       ),
  //       SizedBox(height: 20),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           _colorWidget(LightColor.yellowColor, isSelected: true),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.lightBlue),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.black),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.red),
  //           SizedBox(
  //             width: 30,
  //           ),
  //           _colorWidget(LightColor.skyBlue),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Widget _colorWidget(Color color, {bool isSelected = false}) {
  //   return CircleAvatar(
  //     radius: 12,
  //     backgroundColor: color.withAlpha(150),
  //     child: isSelected
  //         ? Icon(
  //             Icons.check_circle,
  //             color: color,
  //             size: 18,
  //           )
  //         : CircleAvatar(radius: 7, backgroundColor: color),
  //   );
  // }

  // FloatingActionButton _floatingButton() {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //     backgroundColor: LightColor.main,
  //     child: Icon(Icons.arrow_back,
  //         color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
  //   );
  // }

}
