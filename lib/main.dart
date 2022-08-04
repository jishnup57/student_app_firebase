import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/signup/view_mode/auth_service.dart';
import 'package:user_app_fire_pov/user_home/view_mode/user_home_provider.dart';
import 'package:user_app_fire_pov/wrapper/view/wrapper.dart';

void main()async {
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
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (context) => HomeProv(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
       home: const Wrapper(),
      ),
    );
  }
}
