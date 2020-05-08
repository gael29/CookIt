import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';

// Create a Form widget.
class Search extends StatefulWidget  {

  String research;
      Function(String) callback;

      Search(this.research, this.callback);
  @override
  _SearchState createState() {
    return _SearchState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class _SearchState extends State<Search> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<_SearchState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            color: Colors.transparent,
            child: new Container(
                decoration: new BoxDecoration(
                    border : Border.all(width: 4, color : LightColor.main),
                    borderRadius: new BorderRadius.all( Radius.circular(40.0))),
                child: new Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: LightColor.main),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onFieldSubmitted: (text){
                print("First text field: $text");
                widget.callback(text);
              },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
