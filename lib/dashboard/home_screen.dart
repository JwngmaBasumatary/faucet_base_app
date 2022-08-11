import 'dart:math';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import '../models/general_data_model.dart';
import '../models/latest_app.dart';
import '../models/user_stream.dart';
import '../providers/common_providers.dart';
import '../screens/update_screen.dart';
import '../services/firebase_auth_services.dart';
import '../services/firestore_services.dart';
import '../services/remote_config_services.dart';
import '../utils/constants.dart';
import '../utils/tools.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool showLoading = true;
  FirestoreServices fireStoreServices = FirestoreServices();
  FirebaseAuthServices authServices = FirebaseAuthServices();
  int totalUser = 0;

  //Get Latest version info from firebase config
  final RemoteConfig remoteConfig = RemoteConfig.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkIfTodaysLeftClick();
    });

    getLatestReleasedApp();

    super.initState();
  }

  LatestApp? latestApp;

  getLatestReleasedApp() async {
    await RemoteConfigServices.getLatestApp().then((value) {
      latestApp = value;
      setState(() {});
    });
  }


  checkIfTodaysLeftClick() async {
    var commonProvider = Provider.of<CommonProviders>(context, listen: false);

    if (commonProvider.isonline!) {
      Tools.showDebugPrint("  The device was already online");
    } else {
      Tools.showDebugPrint("The device was not online");
      commonProvider.setOnline(true);
      var today = await fireStoreServices.getToday();
      var todayy = await NTP.now();
      if (today != todayy.day) {
        Tools.showDebugPrint("The Last acitive date was different");
        fireStoreServices.addToday();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserStream>(context);
    var generalData = Provider.of<GeneralDataModel>(context);

    if (generalData.appStatus == false) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/maintenance.png",
                  scale: 5.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "App under maintenance",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "The App is currently undergoing scheduled maintenance stage. We should be back shortly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (generalData.blocked == true) {
      return AppBlockedScreen(
        newApp: generalData.newApp!,
      );
    } else if (userData.accountReset == true) {
      return const AccountReset();
    } else {
      if (generalData.appVersion! > Constants.releaseVersionCode) {
        return const UpdateScreen();
      } else {
        return Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  latestApp != null
                      ? GestureDetector(
                          onTap: () {
                            Tools.launchURL(latestApp!.link!);
                          },
                          child: Card(
                            color: Tools.multiColors[
                                Random().nextInt(Tools.multiColors.length - 1)],
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(latestApp!.image!),
                                radius: 25,
                              ),
                              title: Text(
                                '${latestApp?.title}',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${latestApp?.description}"),
                                ],
                              ),
                              trailing: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${latestApp?.point}"),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Tools.launchURL(latestApp!.link!);
                                          },
                                          child: const Text("Download.")))
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Constants.dashboardContainerColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Points ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ((userData.points.toString().isNotEmpty
                                            ? userData.points
                                            : 0)! *
                                        Constants.decimal)
                                    .toStringAsFixed(Constants.decimalLength) +
                                " ${Constants.symbol}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            Constants.appLogo,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Users",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "${generalData.users} Users",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ));
      }
    }
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}

class AppBlockedScreen extends StatelessWidget {
  const AppBlockedScreen({Key? key, required this.newApp}) : super(key: key);

  final String newApp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/lock.png",
                scale: 5.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "App Blocked",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                "Admin has blocked the app for indefinite time. And released new replacement for this app. \nAll your funds are safe and secured.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () {
                    Tools.launchURL(newApp);
                  },
                  child: const Text("Download New App"))
            ],
          ),
        ),
      ),
    );
  }
}

///Account Reset

class AccountReset extends StatelessWidget {
  const AccountReset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/account-reset.png",
                scale: 5.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Account Reset",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                "There has been some issue with your account. Please reset your account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () async {
                    await FirestoreServices().refreshAccount();
                  },
                  child: const Text("Reset Now"))
            ],
          ),
        ),
      ),
    );
  }
}
