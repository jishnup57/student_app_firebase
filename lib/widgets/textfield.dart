import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
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
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon:  Icon(icon,color: Colors.deepOrangeAccent,),
          
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