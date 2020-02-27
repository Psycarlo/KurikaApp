import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/guitar_white_op.png'),
          fit: BoxFit.cover
        ) ,
      ),
    );
  }
}

class SignInPageUITemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/guitar_white_op.png'),
          fit: BoxFit.cover
        ) ,
      ),
      child: Align(
        alignment: const Alignment(0.9, -0.875),
        child: Icon(FeatherIcons.moon),
      ),
    );
  }
}