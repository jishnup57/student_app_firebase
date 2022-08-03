import 'package:flutter/cupertino.dart';

class LoginFunctions {
  
  static double? h;
  static  double? w;
  getWidthAndHeight(BuildContext ctx ){
      h=MediaQuery.of(ctx).size.height;
      w=MediaQuery.of(ctx).size.width;
  }



}