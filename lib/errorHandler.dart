import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ErrorHandler{
  Future<bool?> errorDialog(BuildContext context,e) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Error"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                child: Center(
                  child: Text(
                    e.message.toString()
                  ),
                ),
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("Ok"))
                  ],
                ),
              )

            ],
          ),
        );
      },

    );
  }
}