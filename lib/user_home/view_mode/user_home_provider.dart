import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app_fire_pov/routes/routs.dart';

enum TypeData{
  edit,
  create,
}

class HomeProv with ChangeNotifier {
  String img = '';

  final scaffoldKEY = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  dynamic context;
  setContext(BuildContext ctx) {
    context = ctx;
  }

  //String name=Provider.of<AuthService>(context,listen: false).uniqueEmail;

  disposeController() {
    nameController.clear();
    phoneController.clear();
  }

  pickImage() async {
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

  onAddButtonPressed(CollectionReference products) async {
    final String name = nameController.text;
    final double? phone = double.tryParse(phoneController.text);

    if (phone != null && img.isNotEmpty&& name.isNotEmpty) {
      await products.add({"name": name, "Phone": phone, "image": img});

      disposeController();
      imageToNUll();
      Routes.pop();
    }
  }
   onUpdateButtonPressed(CollectionReference products,DocumentSnapshot documentSnapshot) async {
    final String name = nameController.text;
    final double? phone = double.tryParse(phoneController.text);

    if (phone != null && img.isNotEmpty&& name.isNotEmpty) {

      await products
                            .doc(documentSnapshot.id)
                            .update({"name": name, "Phone": phone, "image": img});
     // await products.add({"name": name, "Phone": phone, "image": img});

      disposeController();
      imageToNUll();
      Routes.pop();
    }
  }

   Future<void> delete(String productId,CollectionReference products) async {
    await products.doc(productId).delete();
    
    showSnakBar('You have successfully deleted a Field');
   
  }


  showSnakBar(String msg) {
    ScaffoldMessenger.of(scaffoldKEY.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(scaffoldKEY.currentContext!)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  checkOperation({TypeData? type,DocumentSnapshot? documentSnapshot}){
    
    if (type==TypeData.edit) {
      nameController.text=documentSnapshot!['name'];
      phoneController.text=documentSnapshot['Phone'].toString();
      img=documentSnapshot['image'];
    }

  }

  String nameConversion(double data){
    return data.toInt().toString();
  }

  // onSubmitButtonCheck({required TypeData type,}CollectionReference products){
  //   switch ( type) {
  //     case TypeData.create :
  //        onAddButtonPressed({CollectionReference products});
  //       break;
  //     default:
  //   }
  // }


}
