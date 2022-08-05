import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/constants/constants.dart';
import 'package:user_app_fire_pov/login/view/screen_login.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';
import 'package:user_app_fire_pov/user_home/widget/floatbutton.dart';
import 'package:user_app_fire_pov/widgets/textfield.dart';

import '../view_mode/user_home_provider.dart';
import '../widget/appbarstyle.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference products =
        FirebaseFirestore.instance.collection(uniqueEmail);
    final MediaQueryData mediqurydata=MediaQuery.of(context);
    return StreamBuilder<User?>(
      stream: context.watch<AuthService>().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const ScreenLogin();
        }
        return Scaffold(
         // resizeToAvoidBottomInset: false,
          key: context.read<HomeProv>().scaffoldKEY,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Welcome'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    await context.read<AuthService>().signOut(context);
                  },
                  icon: const Icon(Icons.logout))
            ],
            flexibleSpace: const StyledAppBar(),
          ),

          body:StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: 
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: MemoryImage(
                              const Base64Decoder()
                                  .convert(documentSnapshot['image'])),
                    ),
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['Phone'].toString()),
                    trailing: IconButton(icon: const Icon(Icons.delete),
                    onPressed: (){
                      delete(documentSnapshot.id,context,products);
                    },
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ) ,



          floatingActionButton: FloatingActionButton(
            onPressed: () {
            
            showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return BottomSheetBody(products: products);
                  },
                );
            
            },
            child: const FloatButton(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
  Future<void> delete(String productId,BuildContext context,CollectionReference products) async {
    await products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }
}

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({
    Key? key,
    required this.products,
  }) : super(key: key);

  final CollectionReference<Object?> products;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediqurydata=MediaQuery.of(context);
    return Padding(
      padding: mediqurydata.viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20,
              left: 8,
              right: 8,
              bottom:30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<HomeProv>(
                builder: (context, value, _) => GestureDetector(
                  child: value.img.isNotEmpty
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: MemoryImage(
                              const Base64Decoder()
                                  .convert(value.img)),
                        )
                      : const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('img/img_avatar.png'),
                        ),
                  onTap: () {
                    context.read<HomeProv>().pickImage();
                  },
                ),
              ),
              kHight10,
              CommonTextField(
                hintText: "Enter name",
                icon: Icons.contact_page,
                controller: context.read<HomeProv>().nameController,
              ),
              kHight10,
              CommonTextField(
                hintText: "Phone Number",
                icon: Icons.phone,
                controller:
                    context.read<HomeProv>().phoneController,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name =
                      context.read<HomeProv>().nameController.text;
                  final double? phone = double.tryParse(context
                      .read<HomeProv>()
                      .phoneController
                      .text);
                  final img=context.read<HomeProv>().img;
                  if (phone != null||img.isNotEmpty) {
                    await products
                        .add({"name": name, "Phone": phone,"image":img});
      
                    context.read<HomeProv>().disposeController();
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange),
                child: const Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
