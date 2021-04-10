import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Services/Auth/firebase_auth.dart';

class WelcomePage extends StatefulWidget {
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool async = false;

  void signIn() async {
    setState(() => async = true);
    await Provider.of<AuthenticationService>(context, listen: false)
        .signInAnonymusli()
        .then((value) => print(value))
        .catchError((err) {
      setState(() => async = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15, right: 30),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: async
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Text(
                      "Welcome to Weight Tracker",
                      style: TextStyle(
                        fontFamily: 'nunito',
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )));
  }
}
