import 'package:flutter/material.dart';
// import 'package:feather_icons_flutter/feather_icons_flutter.dart';

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
            fit: BoxFit.cover),
      ),
    );
  }
}

class SignInPageUITemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgrounds/guitar_white_op.png'),
                  fit: BoxFit.cover,
                ),  
              ),
              child: Stack(
                children: const <Widget>[
                  Text('Test'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
