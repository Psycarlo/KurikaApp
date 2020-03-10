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
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Text('K',
                  style: TextStyle(color: Colors.orange, fontSize: 200)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.orange,
                ),
                Stack(
                  children: const <Widget>[
                    Text('Relatos de Taberna'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
