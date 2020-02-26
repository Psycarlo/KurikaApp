import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/auth_widget.dart';
import 'app/auth_widget_builder.dart';
import 'routes/router.gr.dart';
import 'services/auth_service.dart';
import 'services/firebase_auth_service.dart';
import 'services/firestore_database.dart';

void main() => runApp(
  MyApp(
    authServiceBuilder: (_) => FirebaseAuthService(),
    databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid)
  )
);
 
class MyApp extends StatelessWidget {
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
}