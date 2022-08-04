import 'package:flutter/material.dart';

class StyledAppBar extends StatelessWidget {
  const StyledAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image:DecorationImage(image: AssetImage('img/loginbtn.png'),fit: BoxFit.cover) 
      ),
    );
  }
}