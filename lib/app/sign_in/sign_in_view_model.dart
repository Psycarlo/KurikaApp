import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kurika_app/services/auth_service.dart';
import 'package:kurika_app/services/firebase_auth_service.dart';
import 'package:meta/meta.dart';

class SignInViewModel with ChangeNotifier {
  SignInViewModel({@required this.auth});

  final FirebaseAuthService auth;
  bool isLoading = false;

  // TODO: Review not used
  Future<User> _signIn(Future<User> Function() singInMethod) async {
    try {
      isLoading = true;
      notifyListeners();
      return await singInMethod();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}