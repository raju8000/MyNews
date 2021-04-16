import 'package:flutter/material.dart';

class Utils{

  static Future<void> showLoadingDialog(
      BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return new WillPopScope(
              onWillPop: () async => false,
              child: Container(color: Colors.white54,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        });
  }


  static showMessageDialog(BuildContext context,String msg){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}