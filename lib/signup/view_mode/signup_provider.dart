import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';

class SignUpProv extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 // final scaffoldkey = GlobalKey<ScaffoldState>();

  disposeController() {
    emailController.clear();
    passwordController.clear();
  }

  onSignUpButtonPress(BuildContext ctxSignUp) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showSnakBar('Enter All Fields',ctxSignUp);
      return;
    }
    final msg = await ctxSignUp
        .read<AuthService>()
        .signUp(email, password);
    if (msg == '')  {
    // await shared();
      disposeController();
      return;
    }
    showSnakBar(msg,ctxSignUp);
    disposeController();
  }

  // shared() async {
  //   final obj = await SharedPreferences.getInstance();
  //   uniqueEmail = emailController.text.trim();
  //   obj.setString('mail', emailController.text.trim());
  // }


  showSnakBar(String msg,BuildContext ctx) {
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
    ScaffoldMessenger.of(ctx)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
