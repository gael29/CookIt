import 'dart:ffi';

class Ingredient{
  String name ;
  String image ;
  double amount;
  String unit;
  int recipeId;
  bool isChecked;



  Ingredient({this.name,this.image, this.amount, this.unit,this.recipeId,this.isChecked=false});
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

  factory Ingredient.fromMap(Map<String, dynamic> json) {

  bool checked;

  if(json["isChecked"]==1){
     checked = true;
  }
  else{
     checked = false;
  }


  return new Ingredient(
    recipeId: json["recipeId"],
        name: json["name"],
        image: json["image"],
        amount: json["amount"] as double,
        unit: json["unit"],
        isChecked: checked,
      );
}

 setChecked(){
        this.isChecked=!this.isChecked;
      }
      

}
  