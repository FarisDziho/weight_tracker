import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Services/firestore/firestore.dart';
import '../utils/validator.dart';
import '../models/enteties/weight_record.dart';
import '../utils/misc.dart';
import 'package:uuid/uuid.dart';

class WeightForm extends StatefulWidget {
  String textController = '';
  String dateTime;
  bool isEdit = false;
  String userUid;
  String recordId;

  WeightForm() {
    textController = '';
    isEdit = false;
  }
  WeightForm.editWeight(
      String userUid, String recordId, String weight, String dateTime) {
    this.userUid = userUid;
    this.recordId = recordId;
    this.textController = weight;
    this.dateTime = dateTime;
    this.isEdit = true;
  }

  _WeightFormState createState() => _WeightFormState(textController);
}

class _WeightFormState extends State<WeightForm> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _weightController = new TextEditingController();

  final _fromKey = GlobalKey<FormState>();

  _WeightFormState(String textController) {
    this._weightController.text = textController;
  }

  void addRecord() {
    if (_fromKey.currentState.validate()) {
      String recordId = Uuid().v4();
      double parsedWeight = getNumberWith2Digits(_weightController.text);
      var dateTime = DateTime.now();
      String uid = getUserUid(context);
      WeightRecord wg = WeightRecord(recordId, parsedWeight, dateTime);

      Provider.of<Store>(context, listen: false)
          .addRecord(uid, recordId, dateTime, wg);

      _weightController.text = "";
      hideKeyboard(context);
      Navigator.of(context).pop();
    }
  }

  void editRecord() {
    if (_fromKey.currentState.validate()) {
      double parsedWeight = getNumberWith2Digits(_weightController.text);
      var dateTime = DateTime.parse(this.widget.dateTime);
      String recordId = this.widget.recordId;
      String uid = this.widget.userUid;
      WeightRecord wg = WeightRecord(recordId, parsedWeight, dateTime);

      Provider.of<Store>(context, listen: false)
          .updateRecord(uid, recordId, dateTime.toString(), wg);
      _weightController.text = "";
      hideKeyboard(context);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: _fromKey,
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: TextFormField(
                    autofocus: true,
                    validator: validateWeight,
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        helperText: "Unesite kilazu",
                        hintText: "00.00 Kg"),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: this.widget.isEdit ? editRecord : addRecord,
                    child: this.widget.isEdit ? Text("Edit") : Text("Save"),
                    color: Colors.yellow,
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
