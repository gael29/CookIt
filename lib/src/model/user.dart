class User{
  String id;
  String firstName ;
  String lastName ;
  String email;
  String password ;
  String image;
  List fav;
  List plan;
  List friends;

  User({this.id,this.firstName,this.lastName,this.email,this.password,this.image,this.fav,this.plan,this.friends});

  Map toJson() => {
        'Id': id,
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Image': image,
        'Fav': fav,
        'Plan': plan,
        'Friends': friends,
      };
}