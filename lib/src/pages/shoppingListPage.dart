import 'package:flutter/material.dart';
import 'package:cookit/src/database/database.dart';
import 'package:cookit/src/model/data.dart';
import 'package:cookit/src/model/ingredient.dart';
import 'package:cookit/src/model/product.dart';
import 'package:cookit/src/model/recipe.dart';
import 'package:cookit/src/themes/light_color.dart';
import 'package:cookit/src/themes/theme.dart';
import 'package:cookit/src/wigets/title_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cookit/src/extensions/string_extension.dart';

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Ingredient>>(
        future: DBProvider.db.getAllIngredients(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Ingredient>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Ingredient item = snapshot.data[index];
                return // _item(item)
                      SingleChildScrollView(
                    child: Column(
                      children: <Widget>[ GestureDetector(
        onTap: (){
          setState(() {
           // item.setChecked();
             if(item.isChecked)
          DBProvider.db.updateListChecked(item.name, 0);
          else 
          DBProvider.db.updateListChecked(item.name, 1);
          });
         
        },
        child: 
                        _item(item)
                        ),
                      ],
                    ),
                  
                );
              },
            );
          } else {
            return Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: SpinKitRotatingCircle(
                  color: LightColor.main,
                  size: 50.0,
                ));
          }
        },
      ),
    );
  }

  Widget _item(Ingredient model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    
      height: 85,

      child: Container(
        
      decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: model.isChecked
                                ? LightColor.main
                                : Colors.transparent,
  ),
      child: Row(
        children: <Widget>[
          Container(
             margin: EdgeInsets.only(left:10),
            child: 
          Image(
              image: NetworkImage(model.image),
              height: 40,
              width: 40,
            ),
          ),
          
          
          Expanded(
              child: ListTile(
                  title: 
                        TitleText(
                        text: model.name.capitalize(),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                  
                  subtitle: Row(
                    children: <Widget>[
                      TitleText(
                            text: model.amount.toStringAsFixed(2)
                        .toString()
                        .replaceAll(RegExp(r'.00'), '')+" "+model.unit,
                            fontSize: 16,
                            color: model.isChecked
                                ? LightColor.background
                                : LightColor.main,
                          )
                    ],
                  ),
                  trailing: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check,
                        color: model.isChecked
                                ? LightColor.background
                                : Colors.transparent,
                        size:35
                      )
                      )
                      )
                      )
        ],
      ),
      )
      
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '${AppData.cartList.length} Items',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        // TitleText(
        //   text: '\$${getPrice()}',
        //   fontSize: 18,
        // ),
      ],
    );
  }

  // Widget _submitButton(BuildContext context) {
  //   return FlatButton(
  //       onPressed: () {},
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       color: LightColor.main,
  //       child: Container(
  //         alignment: Alignment.center,
  //         padding: EdgeInsets.symmetric(vertical: 12),
  //         width: AppTheme.fullWidth(context) * .7,
  //         child: TitleText(
  //           text: 'Next',
  //           color: LightColor.background,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ));
  // }

  // double getPrice() {
  //   double price = 0;
  //   AppData.cartList.forEach((x) {
  //     price += x.price * x.id;
  //   });
  //   return price;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: AppTheme.padding,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: <Widget>[
  //           _cartItems(),
  //           Divider(
  //             thickness: 1,
  //             height: 70,
  //           ),
  //           _price(),
  //           SizedBox(height: 30),
  //           _submitButton(context),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
