import 'package:faucet_base_app/home/homepage.dart';
import 'package:faucet_base_app/login/custom/email_login.dart';
import 'package:faucet_base_app/ui/text.dart';
import 'package:faucet_base_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/esports-tournament-app-de5e8.appspot.com/o/temp%2FiconTemp.png?alt=media&token=9d1ab0df-8b6b-4f06-bdc4-972a95b5841c",
              height: 120,
            ),
            const DesignText(
              "Dhamaka Offer",
              color: Constants.blue,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmailLogin(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          side:
                              BorderSide(width: 1, color: Constants.blueGrey)),
                      primary: Colors.white,
                    ),
                    child: const DesignText(
                      'Log in',
                      color: Constants.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          side:
                              BorderSide(width: 1, color: Constants.blueGrey)),
                      primary: Colors.white,
                    ),
                    child: const DesignText(
                      'Sign up',
                      color: Constants.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const DesignText(
              "OR",
              color: Constants.blueGrey,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    },
                    style: TextButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          side:
                              BorderSide(width: 1, color: Constants.blueGrey)),
                      backgroundColor: Colors.white,
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                    label: const DesignText(
                      'LOGIN WITH GOOGLE',
                      color: Constants.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
