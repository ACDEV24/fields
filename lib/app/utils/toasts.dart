import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WalletMessages {
  static final ftoast = FToast();

  static void init() {
    final context =
        Modular.get<GlobalKey<NavigatorState>>().currentState?.context;

    if (context == null) return;

    ftoast.init(context);
  }

  static void showError(String message) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
