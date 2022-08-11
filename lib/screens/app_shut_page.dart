import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/tools.dart';


class AppShutPage extends StatefulWidget {
  const AppShutPage({Key? key}) : super(key: key);

  @override
  _AppShutPageState createState() => _AppShutPageState();
}

class _AppShutPageState extends State<AppShutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  " Due to some technical issue , we are not working currently. Our Development team is working to fix the issue. we will be back very soon. All your funds are safe, do not worry. Thank You",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () => Tools.launchURL(Constants.allAppsWebsite),
                    child: const Text("Check the Status from our website"))
              ],
            ),
          ),
        ),
      ),
    );
  }

}
