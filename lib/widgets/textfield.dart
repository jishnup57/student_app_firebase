import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow:  [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(1,1),
            color: Colors.grey.withOpacity(0.5)
          )
        ]
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:  const BorderSide(
                  color: Colors.white,
                  width: 1.0
                ),
          ),
          enabledBorder:  OutlineInputBorder(
             borderRadius: BorderRadius.circular(30),
                borderSide:  const BorderSide(
                  color: Colors.white,
                  width: 1.0
                ),
          
          ),
        ),
      ),
    );
  }
}