import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Services/Auth/firebase_auth.dart';

String getUserUid(BuildContext context) {
  return Provider.of<AuthenticationService>(context, listen: false)
      .getfirebaseAuth()
      .currentUser
      .uid;
}

String getDateFormat(String dateTime) {
  var parsedDate = DateTime.parse(dateTime);
  return DateFormat('dd - MM - yyyy : hh -mm').format(parsedDate);
}

double getNumberWith2Digits(String stringNumber) {
  double parsedWeight = double.tryParse(stringNumber);
  parsedWeight = double.tryParse(parsedWeight.toStringAsFixed(2));
  return parsedWeight;
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
