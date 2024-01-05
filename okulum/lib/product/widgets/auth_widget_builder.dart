import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/auth_service.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key? key, required this.onPageBuilder})
      : super(key: key);
  final Widget Function(BuildContext context, AsyncSnapshot<User?> snapShot)
      onPageBuilder;

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User?>(
      stream: _authService.onAuthStateChanges,
      builder: (context, AsyncSnapshot<User?> snapShot) {
        final _userData = snapShot.data;
        if (_userData != null) {
          return MultiProvider(providers: [
            Provider.value(value: _userData),
          ], child: onPageBuilder(context, snapShot));
        }
        return onPageBuilder(context, snapShot);
      },
    );
  }
}
