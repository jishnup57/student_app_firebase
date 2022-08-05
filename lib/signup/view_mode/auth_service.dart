import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:user_app_fire_pov/user_home/view_mode/user_home_provider.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _fb;
  AuthService(this._fb);
  Stream<User?> stream() => _fb.authStateChanges();
  // final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  // User? _userFromFirebase(auth.User? user) {
  //   if (user == null) {
  //     return null;
  //   }
  //   return User(user.uid, user.email);
  // }

  // Stream<User?>? get user {
  //   return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  // }

  // Future<User?> signInWithEmailAndPassword(
  //   String email,
  //   String password,
  // ) async {
  //   final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   return _userFromFirebase(credential.user);
  // }

  // Future<User?> createUserWithEmailAndPassword(
  //   String email,
  //   String password,
  // ) async {
  //   final credential = await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   return _userFromFirebase(credential.user);
  // }

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
