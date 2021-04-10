import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/models/enteties/weight_record.dart';

class Store {
  FirebaseFirestore firestore;

  Store(this.firestore);

  void addRecord(
      String uid, String recordId, DateTime dateTime, WeightRecord wg) {
    firestore
        .collection('users')
        .doc(uid)
        .collection("weight_records")
        .doc(recordId)
        .set(wg.toJson())
        .catchError((onError) {
      print(onError);
    });
  }

  void updateRecord(
      String userId, String recordId, String dateTime, WeightRecord wg) {
    firestore
        .collection('users')
        .doc(userId)
        .collection("weight_records")
        .doc(recordId)
        .update(wg.toJson())
        .catchError((onError) {
      print(onError);
    });
  }

  void deleteRecord(
      String uid, String recordId, String dateTime, BuildContext context) {
    firestore
        .collection('users')
        .doc(uid)
        .collection('weight_records')
        .doc(recordId)
        .delete()
        .catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("doslo je do greske")));
    });
  }
}
