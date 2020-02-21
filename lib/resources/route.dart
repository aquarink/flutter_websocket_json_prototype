import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:prototype_ws_momoka/ui/login.dart';
import 'package:prototype_ws_momoka/ui/mainscreen.dart';

class RouteMomoka {
  static Router router = Router();

  //handler screen mainscreen.dart
  static Handler mainscreenHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MainScreen());

  //handler screen login
  static Handler loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Login());

  static void setupRouter() {
    router.define('/mainscreen',
        handler: mainscreenHandler, transitionType: TransitionType.inFromRight);

    router.define('/login',
        handler: mainscreenHandler, transitionType: TransitionType.inFromRight);
  }
}
