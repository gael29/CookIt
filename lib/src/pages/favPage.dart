import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/database/database.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/model/recipe.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavPage extends StatefulWidget {
  FavPage({Key key, this.title}) : super(key: key);
  final String title;
    @override
  _FavPageState createState() => _FavPageState();
}
class _FavPageState extends State<FavPage> {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Recipe>>(
        future: DBProvider.db.getAllFav(),
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Recipe item = snapshot.data[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  background: Container(color: LightColor.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteFav(item.id);
                  },
                   child:// _item(item)
                    SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _item(item),
          ],
        ),
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


  Widget _item(Recipe model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 100,
      child: Row(
        children: <Widget>[
          GestureDetector(
        onTap: (){
           Navigator.of(context).pushNamed('/detail', arguments: model.id);
        },
        child: 
          CircleAvatar(
                      radius: 40,
                      backgroundColor: LightColor.main,
                      child: CircleAvatar(
                        radius: 37.0,
                        backgroundImage: NetworkImage(model.image),
                        backgroundColor: Colors.transparent,
                      ),
           ), ),
          Expanded(
              child: ListTile(
                  title: GestureDetector(
        onTap: (){
           Navigator.of(context).pushNamed('/detail', arguments: model.id);
        },
        child: TitleText(
                    text: model.name,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                   ) ),
                  subtitle: Row(
                    children: <Widget>[
                      GestureDetector(
        onTap: (){
            Navigator.of(context).pushNamed('/detail', arguments: model.id);
        },
        child: 
                      TitleText(
                        text: model.readyInMinutes.toString()+" min de préparation",
                        fontSize: 14,
                        color: LightColor.main,
                      )
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    child: 
                IconButton(
                    icon: Icon(Icons.delete_outline),
                    color: LightColor.main,
                    onPressed: () {
                      setState(() {
                        DBProvider.db.deleteFav(model.id);
                      });
              
                    },
                  )
                
                  )))
        ],
      ),
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
