import 'package:flutter/material.dart';

class RoutesToScreens {
  push({required BuildContext context,required Widget screen}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>screen ));
  }
  pop({required BuildContext context}){
    Navigator.of(context).pop();
  }
}