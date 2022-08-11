import 'package:flutter/material.dart';
import '../config/auth_widget.dart';
import '../services/firebase_auth_services.dart';
import '../utils/constants.dart';

class SplashScreenPage extends StatefulWidget {
  final AsyncSnapshot<User> userSnapshot;
  const SplashScreenPage({Key? key, required this.userSnapshot})
      : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((val) {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AuthWidget(
            userSnapshot: widget.userSnapshot,
          );
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(Constants.appLogo),
                ),
              ),
            ),
            const Center(
              child: Text(
                Constants.appName,
                style:
                    TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  strokeWidth: 5,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  "${Constants.appName} \n For Everyone",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
