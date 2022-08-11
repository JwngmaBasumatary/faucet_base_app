import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/tools.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Spacer(),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(Constants.appLogo),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "Hey, app needs an update",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "We are listening to your feedback and working hard to resolve bugs",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0),
                ),
                const Spacer(),
                const Spacer(),
                const Text("Please update the app for an improved experience"),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      // InAppUpdate.checkForUpdate().then((info) {
                      //   if (info.updateAvailability ==
                      //       UpdateAvailability.updateAvailable) {
                      //     InAppUpdate.startFlexibleUpdate().then((_) {
                      //       Tools.showDebugPrint("Success!");
                      //     }).catchError((e) {
                      //       Tools.showDebugPrint(e.toString());
                      //     });
                      //   }
                      // });

                      // InAppUpdate.performImmediateUpdate().catchError(
                      //     (e) => Tools.showDebugPrint(e.toString()));
                      Tools.launchURL(Constants.appLink);
                    },
                    child: const Text("Update Now"),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
