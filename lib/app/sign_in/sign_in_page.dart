import 'package:flutter/material.dart';

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/backgrounds/guitar_white_op.png'),
          fit: BoxFit.cover
        ) ,
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}