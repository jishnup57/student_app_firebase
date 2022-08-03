import 'package:flutter/material.dart';

class WaveStyle extends StatelessWidget {
    const WaveStyle({
    Key? key,
    required this. imgPath
  }) : super(key: key);
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h * 0.3,
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imgPath), fit: BoxFit.cover)),
    );
  }
}