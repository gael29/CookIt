import 'package:flutter_ecommerce_app/src/model/analizedInstruction.dart';
import 'package:flutter_ecommerce_app/src/model/ingredient.dart';
import 'package:flutter_ecommerce_app/src/model/instruction.dart';

class Detail{
  int id;
  String name ;
  int readyInMinutes ;
  String image ;
  bool isliked ;
  bool isOnList ;
  bool vegetarian ;
  bool vegan ;
  bool glutenFree ;
  bool veryHealthy ;
  int preparationMinutes;
  int cookingMinutes;
  int servings;
  String summary;
  List<Ingredient> ingredients;
  List<AnalizedInstruction> analizedInstructions;


  Detail({this.id,this.name, this.readyInMinutes, this.isliked=false,this.isOnList=false,this.image,this.vegetarian,this.vegan,this.glutenFree,this.cookingMinutes,this.veryHealthy,this.preparationMinutes,this.servings,this.summary,this.ingredients,this.analizedInstructions});

  
  factory Detail.fromJson(dynamic json) {
    String img;
    if(json['image']?.isEmpty ?? true){
      img = "https://i.picsum.photos/id/292/300/300.jpg?blur=5";
    }
    else{
      img = json['image'];
    }

      var IngredientObjsJson = json['extendedIngredients'] as List;
      List<Ingredient> _ingredients = IngredientObjsJson.map((tagJson) => Ingredient.fromJson(tagJson)).toList();

      var AnalizedObjsJson = json['analyzedInstructions'] as List;
      List<AnalizedInstruction> _analized = AnalizedObjsJson.map((tagJson) => AnalizedInstruction.fromJson(tagJson)).toList();


    return new Detail(
      id: json['id'] as int,
      name: json['title'] as String,
      readyInMinutes : json['readyInMinutes'] as int,
      image : img as String,
      vegetarian : json['vegetarian'] as bool,
      vegan : json['vegan'] as bool,
      glutenFree : json['glutenFree'] as bool,
      veryHealthy : json['veryHealthy'] as bool,
      preparationMinutes : json['preparationMinutes'] as int,
      cookingMinutes : json['cookingMinutes'] as int,
      servings : json['servings'] as int,
      summary: json['summary'] as String,
      ingredients: _ingredients,
      analizedInstructions: _analized
      
    );
  }

  void addServings(){
    if(this.servings<20){
    int oldServings=this.servings;
    this.servings=this.servings+1;
    for (var ind in this.ingredients)
    ind.setAmount(oldServings, this.servings);
    }
  }

  void removeServings(){
    if(this.servings>1){
    int oldServings=this.servings;
    this.servings=this.servings-1;
    for (var ind in this.ingredients)
    ind.setAmount(oldServings, this.servings);
    }
  }

  void setServings(int oldServ, int newServ){

    for (var ind in this.ingredients)
    ind.setAmount(oldServ,newServ);

  }

  void setLike(){
    this.isliked = !this.isliked;
  }

  void setList(){
    this.isOnList = !this.isOnList;
  }

}
  