import 'package:flutter/material.dart';
import 'package:kurika_app/app/auth_widget.dart';
import 'package:kurika_app/app/auth_widget_builder.dart';
import 'package:kurika_app/routes/router.gr.dart';
import 'package:kurika_app/services/auth_service.dart';
import 'package:kurika_app/services/firebase_auth_service.dart';
import 'package:kurika_app/services/firestore_database.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    authServiceBuilder: (_) => FirebaseAuthService(),
    databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    this.authServiceBuilder,
    this.databaseBuilder,
  }) : super(key: key);

  final FirebaseAuthService Function(BuildContext context) authServiceBuilder;
  final FirestoreDatabase Function(BuildContext context, String uid)
    databaseBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: authServiceBuilder,
        ),
      ],
      child: AuthWidgetBuilder(
        databaseBuilder: databaseBuilder,
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            // TODO: Themes changing
            theme: ThemeData(primarySwatch: Colors.orange),
            debugShowCheckedModeBanner: false,
            home: AuthWidget(userSnapshot: userSnapshot),
            // TODO: Do routes
            onGenerateRoute: Router.onGenerateRoute,
          );
        }, 
      ),
    );
  }
}