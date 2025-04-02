import 'package:flutter/material.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(Widget view) {

    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => view,));

  }

  void navigateAndReplacement(Widget view) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => view,)
    );
  }

  void navigateAndRemoveUntil(Widget view) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => view,),
      (route) => false,
    );
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

}