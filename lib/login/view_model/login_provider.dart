
import 'package:flutter/cupertino.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';
import 'package:provider/provider.dart';

class LoginProv with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  onSignInButtonPress(BuildContext context) {
    final email = emailController.text;
    final password = passwordController.text;
    if (email.isEmpty||password.isEmpty) {
      return;
    }
    context.read<AuthService>().signInWithEmailAndPassword(email, password);
  }
}
