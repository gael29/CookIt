import 'dart:ffi';

class Ingredient{
  String name ;
  String image ;
  double amount;
  String unit;


  Ingredient({this.name,this.image, this.amount, this.unit});
  factory Ingredient.fromJson(dynamic json) {
    return new Ingredient(
      name: json['name'] as String,
      image: "https://spoonacular.com/cdn/ingredients_100x100/"+json['image'] as String,
      amount : json['amount'] as double,
      unit : json['unit'] as String   
      
    );


  }

  void setAmount(int oldServings, int newServings){
    this.amount = this.amount / oldServings * newServings;

  }

}
  