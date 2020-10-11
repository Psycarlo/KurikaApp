import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurika_app/app/sign_in/sign_in_view_model.dart';
import 'package:kurika_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kurika_app/constants/keys.dart';
import 'package:kurika_app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth =
      Provider.of<FirebaseAuthService>(context, listen: false);
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(auth: auth),
      child: Consumer<SignInViewModel>(
        builder: (_, SignInViewModel viewModel, __) => SignInPage._(
          viewModel: viewModel,
          title: 'Kurika',
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({
    Key key,
    this.viewModel,
    this.title,
  }) : super(key: key);

  final SignInViewModel viewModel;
  final String title;

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);

  Future<void> _showSignInError(
    BuildContext context,
    PlatformException exception
  ) async {
    await PlatformExceptionAlertDialog(
      // TODO: Localize this title
      title: 'Failed',
      exception: exception,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: const Text('Kurika'),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return null;
  }
}
