import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      photoUrl: user.photoUrl,
      displayName: user.displayName,
    );
  }

  @override
  Future<User> createUserWithEmailAndPassword(
    String email, 
    String password
  ) async {
    final AuthResult authResult = await _firebaseAuth
      .createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  void dispose() {}

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
      .signInWithCredential(EmailAuthProvider.getCredential(
        email: email,
        password: password
      ));
      return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}