import 'package:faucet_base_app/dashboard/home_page.dart';
import 'package:faucet_base_app/screens/login/custom/login.dart';
import 'package:flutter/material.dart';
import '../services/firebase_auth_services.dart';

class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<User> userSnapshot;

  const AuthWidget({Key? key, required this.userSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(userSnapshot.connectionState.toString());
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? const HomePage() : const LoginPage();
    }
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    ));
  }
}
