import 'dart:convert';

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

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: context.watch<AuthService>().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return  const ScreenLogin();
        }
        return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Welcome'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async{
                await context.read<AuthService>().signOut(context);
                  
                },
                icon: const Icon(Icons.logout))
          ],
          flexibleSpace: const StyledAppBar(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: 8,
                      right: 8,
                      bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
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
                        controller: context.read<HomeProv>().phoneController,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style:
                            ElevatedButton.styleFrom(primary: Colors.deepOrange),
                        child: const Text('Add'),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: const FloatButton(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
      },
 
    );
  }
}
