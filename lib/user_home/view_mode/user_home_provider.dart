import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class HomeProv with ChangeNotifier {
  String img='';

  final scaffoldKEY =GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  dynamic context;
  setContext(BuildContext ctx){
      context=ctx;
  }

  //String name=Provider.of<AuthService>(context,listen: false).uniqueEmail;

 disposeController() {
    nameController.clear();
    phoneController.clear();
  }
 

  pickImage()async{
     final imageFromGallery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFromGallery == null) {
      return;
    }
    final bytes = await imageFromGallery.readAsBytes();
    img = base64Encode(bytes);
    notifyListeners();
  }
  imageToNUll() {
    img = '';
  }
}