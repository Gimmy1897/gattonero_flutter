import 'package:flutter/material.dart';

enum alertDialogAction { cancel, save }

class Dialogs {
  static Future<alertDialogAction> alertDialog(
    BuildContext context,
    String title,
    String body,
    String cancel,
    String save,
  ) {
    Future<alertDialogAction> action = showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                  onPressed: () =>
                      Navigator.pop(context, alertDialogAction.cancel),
                  child: Text(cancel)),
              RaisedButton(
                  color: Colors.orange,
                  onPressed: () =>
                      Navigator.of(context).pop(alertDialogAction.save),
                  child: Text(
                    save,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
    return (action != null) ? action : alertDialogAction.cancel;
  }
}
/*final action= await Dialogs.alertDialog(context,"Title","Body","Cancel","Save");
   //cancel and save are the button text for cancel and save operation
   if(action==alertDialogAction.save){
     //do something
     Navigator.pop(context);
   }*/
