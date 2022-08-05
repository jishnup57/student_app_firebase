import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';

class SignUpProv extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  disposeController() {
    emailController.clear();
    passwordController.clear();
  }

  onSignUpButtonPress() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showSnakBar('Enter All Fields');
      return;
    }
    final msg = await scaffoldkey.currentContext!
        .read<AuthService>()
        .signUp(email, password);
    if (msg == '') {
      disposeController();
      return;
    }
    showSnakBar(msg);
    disposeController();
  }

  showSnakBar(String msg) {
    ScaffoldMessenger.of(scaffoldkey.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(scaffoldkey.currentContext!)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
