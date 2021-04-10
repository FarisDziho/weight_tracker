import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmUserAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please confirm you action"),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Colors.red,
                onPressed: () => Navigator.of(context).pop(false),
                child: Container(
                  child: Center(
                    child: Text("NO"),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                color: Colors.yellow,
                onPressed: () => Navigator.of(context).pop(true),
                child: Container(
                  child: Center(
                    child: Text("Yes"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
