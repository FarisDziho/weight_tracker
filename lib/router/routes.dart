import 'package:get/get.dart';
import 'package:weight_tracker/pages/home_page/home_page.dart';
import 'package:weight_tracker/pages/welcome_page/welcome_page.dart';

final routes = [
  GetPage(name: "Welcome", page: () => WelcomePage()),
  GetPage(name: "HomePage", page: () => HomePage())
];
