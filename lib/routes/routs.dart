import 'package:flutter/material.dart';

class Routes {

 static final navigatorKey=GlobalKey<NavigatorState>();
 static push({required Widget screen}){
   // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>screen ));
   navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) =>screen ));
  }
 static pop(){
  navigatorKey.currentState?.pop();
   // Navigator.of(context).pop();
  }
}