import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/constants/constants.dart';
import 'package:user_app_fire_pov/login/view/screen_login.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';
import 'package:user_app_fire_pov/user_home/widget/floatbutton.dart';

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
    return StreamBuilder<User?>(
      stream: context.watch<AuthService>().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const ScreenLogin();
        }
        return Scaffold(
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
          body: StreamBuilder(
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
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return BottomSheetBody(
                                products: products,
                                type: TypeData.edit,
                                documentSnapshot: documentSnapshot,
                              );
                            },
                          );
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: MemoryImage(const Base64Decoder()
                              .convert(documentSnapshot['image'])),
                        ),
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(context
                            .read<HomeProv>()
                            .nameConversion(documentSnapshot['Phone'])),
                        //  subtitle: Text(documentSnapshot['Phone'].toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<HomeProv>()
                                .delete(documentSnapshot.id, products);
                            context.read<HomeProv>().showSnakBar(
                                'You have successfully deleted a Field',
                                context);
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return BottomSheetBody(
                    products: products,
                    type: TypeData.create,
                  );
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
}

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({
    Key? key,
    required this.products,
    required this.type,
    this.documentSnapshot,
  }) : super(key: key);
  final TypeData type;
  final CollectionReference<Object?> products;
  final DocumentSnapshot? documentSnapshot;

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  @override
  void initState() {
    context.read<HomeProv>().checkOperation(
        documentSnapshot: widget.documentSnapshot, type: widget.type);
    super.initState();
  }
    final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext bcontext) {
    final MediaQueryData mediqurydata = MediaQuery.of(bcontext);
    return Padding(
      padding: mediqurydata.viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 30),
          child: Form(
             key:formKey ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<HomeProv>(
                  builder: (context, value, _) => GestureDetector(
                    child: value.img.isNotEmpty
                        ? CircleAvatar(
                            radius: 30,
                            backgroundImage: MemoryImage(
                                const Base64Decoder().convert(value.img)),
                          )
                        : const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('img/img_avatar.png'),
                          ),
                    onTap: () {
                      bcontext.read<HomeProv>().pickImage();
                    },
                  ),
                ),
                kHight10,
                TextFormField(
                  controller:  bcontext.read<HomeProv>().nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.contact_page,color: Colors.deepOrangeAccent,),
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'you should enter name';
                    }
                    return null;
                  },
                ),
                kHight10,
                TextFormField(
                  controller:  bcontext.read<HomeProv>().phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android,color: Colors.deepOrangeAccent,),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Phone number should not be empty';
                    }
                    return null;
                  },
                ),
                kHight10,
                ElevatedButton(
                  onPressed: () {

                    bcontext.read<HomeProv>().keyBoardHide(bcontext);
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    bcontext.read<HomeProv>().onSubmitButtonCheck(
                        type: widget.type,
                        products: widget.products,
                        documentSnapshot: widget.documentSnapshot);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  child: Text(widget.type == TypeData.create ? 'Add' : 'Update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

