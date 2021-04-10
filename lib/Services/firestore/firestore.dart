import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/models/enteties/weight_record.dart';

class Store {
  FirebaseFirestore firestore;

  Store(this.firestore);

  void addRecord(String uid, DateTime dateTime, WeightRecord wg) {
    firestore
        .collection('users')
        .doc(uid)
        .collection("weight_records")
        .doc(dateTime.toIso8601String())
        .set(wg.toJson())
        .catchError((onError) {
      print(onError);
    });
  }

  void updateRecord(String userId, String dateTime, WeightRecord wg) {
    firestore
        .collection('users')
        .doc(userId)
        .collection("weight_records")
        .doc(dateTime)
        .update(wg.toJson())
        .catchError((onError) {
      print(onError);
    });
  }

  void deleteRecord(String uid, String dateTime, BuildContext context) {
    firestore
        .collection('users')
        .doc(uid)
        .collection('weight_records')
        .doc(dateTime)
        .delete()
        .catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("doslo je do greske")));
    });
  }
}
