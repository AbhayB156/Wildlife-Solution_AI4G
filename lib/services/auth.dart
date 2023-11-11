import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:wildlife_solution/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on firebase user
  Usr? _userFromFirebaseUser(User? user) {
    return user != null ? Usr(uid: user.uid) : null;
  }

  Stream<Usr?> get user {
    return _auth
        .authStateChanges()
        // .map((User? user) => _userFromFirebaseUser(user!));
        .map(_userFromFirebaseUser);
  }

  //sign in auno
  Future signinAunon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in email and pass
  Future signInWithEmailandPassword(String email, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //register email and pass
  Future registerWithEmailandPassword(String email, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
