import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:kurika_app/services/auth_service.dart';

class MockAuthService implements AuthService {
  MockAuthService({
    this.startupTime = const Duration(milliseconds: 200),
    this.responseTime = const Duration(seconds: 2)
  }) {
    Future<void>.delayed(responseTime).then((_) {
      _add(null);
    });
  }

  final Duration startupTime;
  final Duration responseTime;

  final Map<String, _UserData> _usersStore = <String, _UserData>{};

  User _currentUser;

  final StreamController<User> _onAuthStateChangedController =
    StreamController<User>();
  @override
  Stream<User> get onAuthStateChanged => _onAuthStateChangedController.stream;

  void _add(User user) {
    _currentUser = user;
    _onAuthStateChangedController.add(user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
    String email,
    String password
  ) async {
    await Future<void>.delayed(responseTime);
    if (_usersStore.keys.contains(email)) {
      throw PlatformException(
        code: 'ERROR_EMAIL_ALREADY_IN_USE',
        message: 'The email address is already registered. Sign in instead?'
      );
    }
    final User user = User(
      uid: 'm1u1dt3ststr1ng',
      email: email
    );
    _usersStore[email] = _UserData(password: password, user: user);
    _add(user);
    return user;
  }

  @override
  Future<User> currentUser() async {
    await Future<void>.delayed(startupTime);
    return _currentUser;
  }

  @override
  void dispose() {
    _onAuthStateChangedController.close();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future<void>.delayed(responseTime);
    if (!_usersStore.keys.contains(email)) {
      throw PlatformException(
        code: 'ERROR_USER_NOT_FOUND',
        message: 'The email address is not registered. Need an account?'
      );
    }
    final _UserData _userData = _usersStore[email];
    if (_userData.password != password) {
      throw PlatformException(
        code: 'ERROR_WRONG_PASSWORD',
        message: 'The password is incorrect. Please try again.'
      );
    }
    _add(_userData.user);
    return _userData.user;
  }

  @override
  Future<void> signOut() async {
    _add(null);
  }
}

class _UserData {
  _UserData({
    @required this.password,
    @required this.user
  });
  final String password;
  final User user;
}