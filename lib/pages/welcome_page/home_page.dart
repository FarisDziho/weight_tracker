import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Services/Auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/components/custom_list_tile.dart';
import 'package:weight_tracker/utils/misc.dart';
import '../../components/weight_input.dart';
import '../../Services/firestore/firestore.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  void deleteRecord(String dateTime) {
    var uid = getUserUid(context);
    Provider.of<Store>(context, listen: false)
        .deleteRecord(uid, dateTime, context);
  }

  @override
  Widget build(BuildContext context) {
    String uid = getUserUid(context);
    return SafeArea(
      child: GestureDetector(
        // onTap: () => hideKeyboard(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Weight Tracker"),
            actions: [
              GestureDetector(
                onTap: () =>
                    Provider.of<AuthenticationService>(context, listen: false)
                        .signOut(),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(children: [
            WeightForm(),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Provider.of<Store>(context)
                      .firestore
                      .collection('users')
                      .doc(uid)
                      .collection("weight_records")
                      .orderBy('dateTime', descending: true)
                      .snapshots(),
                  builder: (BuildContext contex,
                      AsyncSnapshot<QuerySnapshot> snapshots) {
                    if (snapshots.hasError)
                      return Center(child: Text("something went wrong"));

                    if (snapshots.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());

                    return ListView.builder(
                        itemCount: snapshots.data.size,
                        itemBuilder: (BuildContext context, int index) {
                          var data = snapshots.data.docs[index].data();
                          return CustomListTile(
                              uid, data['weight'].toString(), data['dateTime']);
                        });
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
