import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home/home_page.dart';
import 'sign_in/sign_in_page.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    Key key,
    @required this.userSnapshot
  }) : super(key: key);

  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : SignInPageBuilder();
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}