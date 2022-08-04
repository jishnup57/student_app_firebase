import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/routes/routs.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';
import 'package:user_app_fire_pov/widgets/textfield.dart';
import 'package:user_app_fire_pov/widgets/wave_style.dart';

class ScreenSignUP extends StatelessWidget {
   ScreenSignUP({Key? key}) : super(key: key);
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final authService=Provider.of<AuthService>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const WaveStyle(
            imgPath: 'img/signup.png',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: w,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: w,
                  child: const Text(
                    'Create your account',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 CommonTextField(
                  hintText: 'Your email',
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                 CommonTextField(
                  hintText: 'Your password',
                  icon: Icons.lock,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: w * .5,
            height: h * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                  image: AssetImage('img/loginbtn.png'), fit: BoxFit.cover),
            ),
            child:  Center(
              child: InkWell(
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () async{
                  final email=emailController.text;
                  final password=passwordController.text;
                 await authService.createUserWithEmailAndPassword(email, password);
                 RoutesToScreens().pop(context: context);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          RichText(
            text:  TextSpan(
                text: "Already have an account?",
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                children: [
                  TextSpan(
                    text: " Login",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap=()=>RoutesToScreens().pop(context: context)
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
