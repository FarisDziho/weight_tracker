import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/Services/firestore/firestore.dart';
import 'package:weight_tracker/pages/welcome_page/home_page.dart';
import 'package:weight_tracker/pages/welcome_page/welcome_page.dart';
import './router/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Services/Auth/firebase_auth.dart';
import 'models/enteties/weight_record.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) =>
                  context.read<AuthenticationService>().authStateChanges,
              initialData: null),
          Provider<Store>(create: (_) => Store(FirebaseFirestore.instance))
        ],
        builder: (context, child) => GetMaterialApp(
              title: 'Weight Tracker',
              getPages: routes,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: AuthWrapper(),
            ));
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<User>();

    if (authUser == null)
      return WelcomePage();
    else
      return HomePage();
  }
}
