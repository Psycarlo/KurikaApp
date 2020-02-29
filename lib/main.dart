import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'app/sign_in/sign_in_page.dart'; // Temp
/* import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/auth_widget.dart';
import 'app/auth_widget_builder.dart';
import 'routes/router.gr.dart';
import 'services/auth_service.dart';
import 'services/firebase_auth_service.dart';
import 'services/firestore_database.dart'; */

/* void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MyApp(
        authServiceBuilder: (_) => FirebaseAuthService(),
        databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
      ),
    );
  });
} */

/* class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    this.authServiceBuilder,
    this.databaseBuilder
  }): super(key: key);

  final FirebaseAuthService Function(BuildContext context) authServiceBuilder;
  final FirestoreDatabase Function(BuildContext context, String uid)
    databaseBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>( 
          create: authServiceBuilder,
        )
      ],
      child: AuthWidgetBuilder(
        databaseBuilder: databaseBuilder,
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            // TODO: Themes
            theme: ThemeData(primarySwatch: Colors.orange),
            home: AuthWidget(userSnapshot: userSnapshot),
            onGenerateRoute: Router.onGenerateRoute
          );
        }
      ),
    );
  }
} */

void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      home: SignInPageUITemp(),
    );
  }
}