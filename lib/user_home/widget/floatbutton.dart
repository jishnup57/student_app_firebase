
import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color.fromARGB(255, 224, 151, 24), Color.fromARGB(255, 243, 33, 177)])),
        child: const Icon(Icons.add),
      );
  }
}
