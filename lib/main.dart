import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/login/view_model/login_provider.dart';
import 'package:user_app_fire_pov/routes/routs.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';
import 'package:user_app_fire_pov/signup/view_mode/signup_provider.dart';
import 'package:user_app_fire_pov/user_home/view/user_home.dart';
import 'package:user_app_fire_pov/user_home/view_mode/user_home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: ((context) => context.watch<AuthService>().stream()),
            initialData: null),
        ChangeNotifierProvider(
          create: (context) => HomeProv(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProv(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProv(),
        )
      ],
      child: MaterialApp(
        navigatorKey: Routes.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserHome(),
      ),
    );
  }
}
