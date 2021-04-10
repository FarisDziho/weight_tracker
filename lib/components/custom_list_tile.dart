import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Services/firestore/firestore.dart';
import 'package:weight_tracker/utils/misc.dart';

class CustomListTile extends StatefulWidget {
  final String uid;
  final String weight;
  final String dateTime;

  CustomListTile(this.uid, this.weight, this.dateTime);

  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  void deleteRecord() {
    Provider.of<Store>(context, listen: false)
        .deleteRecord(this.widget.uid, this.widget.dateTime, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.pink)),
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        title: Row(children: [
          Container(
            child: Text("Kg:  ${this.widget.weight}"),
          ),
          SizedBox(width: 15),
          Text("datum:  ${getDateFormat(this.widget.dateTime)}"),
        ]),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                child: Container(
                  child: Icon(Icons.edit),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: deleteRecord,
                child: Container(
                  child: Icon(Icons.delete),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
