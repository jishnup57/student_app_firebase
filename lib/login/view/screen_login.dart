import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/routes/routs.dart';
import 'package:user_app_fire_pov/signup/view/signup_screen.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';
import 'package:user_app_fire_pov/widgets/textfield.dart';
import 'package:user_app_fire_pov/widgets/wave_style.dart';

class ScreenLogin extends StatelessWidget {
   ScreenLogin({Key? key}) : super(key: key);
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const WaveStyle(
            imgPath: 'img/loginimg.png',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: w,
                  child: const Text(
                    'hello',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: w,
                  child: const Text(
                    'Sign into your account',
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
                Row(
                  children: const [
                    Spacer(),
                    Text(
                      "forgot your password?",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            child: Container(
              width: w * .5,
              height: h * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                    image: AssetImage('img/loginbtn.png'), fit: BoxFit.cover),
              ),
              child: const Center(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              final email=emailController.text;
              final password=passwordController.text;
              authService.signInWithEmailAndPassword(email, password);
            },
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            child: RichText(
              text: const TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  children: [
                    TextSpan(
                      text: " Create",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            onTap: () => RoutesToScreens().push(context: context, screen:  ScreenSignUP()),
          ),
        ],
      ),
    );
  }
}
