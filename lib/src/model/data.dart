import 'package:flutter_ecommerce_app/src/model/category.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/model/recipe.dart';

class AppData {
   static List<Recipe> recipeList = [
    Recipe(
        id:1,
        name:'Pizza',
        image: 'https://spoonacular.com/recipeImages/three-cheese-pizza-for-cheese-lovers-215435.jpg',
        readyInMinutes: 45),
    Recipe(
        id:2,
        name: 'Fromage grillé',
        image: 'https://spoonacular.com/recipeImages/grilled-cheese-323420.jpeg',
        readyInMinutes: 15),
    Recipe(
        id:3,
        name:'Pizza',
        image: 'https://spoonacular.com/recipeImages/three-cheese-pizza-for-cheese-lovers-215435.jpg',
        readyInMinutes: 20),
  ];

  // static List<Recipe> testFav = [
  //   Recipe(id: 11111,name:"azer",readyInMinutes: 12,image: "azert",isLiked: true,isOnList: true),
  //   Recipe(id: 211,name:"tttt",readyInMinutes: 1,image: "azezefrt",isLiked: true,isOnList: true),
  //   Recipe(id: 33,name:"azezefr",readyInMinutes: 13,image: "ert",isLiked: true,isOnList: true),
  // ];

  static List<Product> productList = [
    Product(
        id:1,
        name: 'Nikfefze Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shooe_tilt_1.png',
        category: "Trending Now"),
    Product(
        id:2,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),
            Product(
        id:2,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),
            Product(
        id:2,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),
            Product(
        id:2,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),
            Product(
        id:2,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),
  ];
  static List<Product> cartList = [
    Product(
        id:1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/small_tilt_shoe_1.png',
        category: "Trending Now"),
    Product(
        id:2,
        name: 'Nike Air Max 97',
        price: 190.00,
        isliked: false,
        image: 'assets/small_tilt_shoe_2.png',
        category: "Trending Now"),
    Product(
        id:1,
        name: 'Nike Air Max 92607',
        price: 220.00,
        isliked: false,
        image: 'assets/small_tilt_shoe_3.png',
        category: "Trending Now"),
     Product(
        id:2,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/small_tilt_shoe_1.png',
        category: "Trending Now"),
    // Product(
    //     id:1,
    //     name: 'Nike Air Max 97',
    //     price: 190.00,
    //     isliked: false,
    //     image: 'assets/small_tilt_shoe_2.png',
    //     category: "Trending Now"),
  ];
  static List<Category> categoryList = [
    Category(),
    Category(id:1,name: "Sneakers",image: 'assets/shoe_thumb_2.png',isSelected: true),
    Category(id:2,name: "Jacket", image: 'assets/jacket.png'),
    Category(id:3,name: "Watch", image: 'assets/watch.png'),
    Category(id:4,name: "Watch", image: 'assets/watch.png'),
  ];
  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];
  static String description = "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
