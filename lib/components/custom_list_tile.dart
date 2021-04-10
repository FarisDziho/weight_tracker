import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Services/firestore/firestore.dart';
import 'package:weight_tracker/components/weight_input.dart';
import 'package:weight_tracker/utils/misc.dart';

class CustomListTile extends StatefulWidget {
  final String userUid;
  final String weight;
  final String dateTime;

  CustomListTile(this.userUid, this.weight, this.dateTime);

  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  void deleteRecord() {
    Provider.of<Store>(context, listen: false)
        .deleteRecord(this.widget.userUid, this.widget.dateTime, context);
  }

  void showEditRecordDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return new AlertDialog(
            content: WeightForm.editWeight(
                this.widget.userUid, this.widget.weight, this.widget.dateTime),
            actions: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(child: Text("Zatvori")),
              )
            ],
          );
        });
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
            width: 100,
            child: Text("Kg:  ${this.widget.weight}"),
          ),
          Text("datum:  ${getDateFormat(this.widget.dateTime)}"),
        ]),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: showEditRecordDialog,
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
