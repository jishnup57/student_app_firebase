import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class HomeProv with ChangeNotifier {
  String img='';
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