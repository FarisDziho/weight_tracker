import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Services/firestore/firestore.dart';
import 'package:weight_tracker/components/confirmUserAcion.dart';
import 'package:weight_tracker/components/weight_input.dart';
import 'package:weight_tracker/utils/misc.dart';

class CustomListTile extends StatefulWidget {
  final String userUid;
  final String recordId;
  final String weight;
  final String dateTime;

  CustomListTile(this.userUid, this.recordId, this.weight, this.dateTime);

  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  void deleteRecord() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.all(20),
              content: ConfirmUserAction(),
            )).then((value) {
      if (value) {
        Provider.of<Store>(context, listen: false).deleteRecord(
            this.widget.userUid,
            this.widget.recordId,
            this.widget.dateTime,
            context);
      }
    });
  }

  void showEditRecordDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return new AlertDialog(
            content: WeightForm.editWeight(this.widget.userUid,
                this.widget.recordId, this.widget.weight, this.widget.dateTime),
            actions: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    child: Icon(
                  Icons.close,
                  size: 20,
                )),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        title: Row(children: [
          Container(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: Text("${this.widget.weight} Kg"),
          ),
          Text(getDateFormat(this.widget.dateTime)),
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
