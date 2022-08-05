
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/user_home/view_mode/user_home_provider.dart';
 String uniqueEmail='user';
class AuthService extends ChangeNotifier {
  final FirebaseAuth _fb;
  AuthService(this._fb);
 
  Stream<User?> stream() => _fb.authStateChanges();
 
  bool _isLoading = false;

  bool get loading => _isLoading;

 

  Future<String> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _fb.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _isLoading = false;
      notifyListeners();
      uniqueEmail=email;
      //log(uniqueEmail.toString());
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _fb.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uniqueEmail=email;
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future<void> signOut(BuildContext context) async {
    Provider.of<HomeProv>(context, listen: false).imageToNUll();
    await _fb.signOut();
  }
}
