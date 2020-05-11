import 'dart:convert';

class Recipe{
  int id;
  String name ;
  int readyInMinutes ;
  String image ;
  bool isLiked ;
  bool isOnList ;
  bool isChecked;

  Recipe clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Recipe.fromMap(jsonData);
}

String clientToJson(Recipe data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

  Recipe({this.id,this.name, this.readyInMinutes,this.image,this.isLiked, this.isOnList,this.isChecked=false});

  RecipeFav(int id,String name,int readyInMinutes,String image, bool isLiked,bool isOnList ){
    this.id = id;
    this.name = name;
    this.readyInMinutes = readyInMinutes;
    this.image = image;
    this.isLiked = isLiked;
    this.isOnList = isOnList;
  }

  
  factory Recipe.fromJson(Map<String, dynamic> json) {
    String img;
    if(json['image']?.isEmpty ?? true){
      img = "https://i.picsum.photos/id/292/300/300.jpg?blur=5";
    }
    else{
      img = "https://spoonacular.com/recipeImages/"+json['image'];
    }
    return new Recipe(
      id: json['id'] as int,
      name: json['title'] as String,
      readyInMinutes : json['readyInMinutes'] as int,
      isLiked: false,
      isOnList: false,
      image : img as String
      
    );
  }

factory Recipe.fromMap(Map<String, dynamic> json) {
  // bool liked = json["isLiked"];
  // bool list = json["list"];
  bool liked;
  bool listed;
  if(json["isLiked"]==1){
     liked = true;
  }
  else{
     liked = false;
  }
  if(json["list"]==1){
     listed = true;
  }
  else{
     listed = false;
  }

  return new Recipe(
    id: json["id"],
        name: json["name"],
        readyInMinutes: json["readyInMinutes"],
        image: json["image"],
        isLiked: liked,
        isOnList: listed,
      );
}
        

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "readyInMinutes": readyInMinutes,
        "image": image,
        "isLiked": isLiked,
        "isOnList":isOnList
      };


      setChecked(){
        this.isChecked=!this.isChecked;
      }

}
  