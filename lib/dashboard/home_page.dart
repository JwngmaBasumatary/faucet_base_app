import 'dart:async';
import 'dart:io';
import 'package:faucet_base_app/screens/wallet/redeem.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../models/user_stream.dart';
import '../providers/connectivity_provider.dart';
import '../screens/app_shut_page.dart';
import '../screens/no_internet.dart';
import '../services/firebase_auth_services.dart';
import '../services/firestore_services.dart';
import '../utils/constants.dart';
import '../utils/tools.dart';
import '../widgets/ui/text.dart';
import 'home_screen.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _signOut(BuildContext context) async {
      ProgressDialog progressDialog = ProgressDialog(
        context: context,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );

      progressDialog.show();
      var firebaseAuthServices = FirebaseAuthServices();

      try {
        firebaseAuthServices.signOutWhenGoogle();
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        title: const DesignText(
          "Home",
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Constants.dashboardContainerColor,
              ),
              accountName: const Text(
                Constants.appName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "Email@gmail.com",
                // userData.email!.isNotEmpty ? userData.email! : "",
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    // userData.profilePhoto!.isNotEmpty
                    //     ? userData.profilePhoto!
                    //     : Constants.appLogoForDynamicLink,
                    Constants.appLogoForDynamicLink,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text("Home"),
              leading: const Icon(FontAwesomeIcons.house),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              },
            ),
            Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(FontAwesomeIcons.rightFromBracket),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).pop();
                _signOut(context);
              },
            ),
            Divider(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 40,
            color: Constants.blueDark,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/money.svg",
                                height: 55,
                              ),
                              const SizedBox(width: 6),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  DesignText(
                                    "Wallet Money:",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  DesignText(
                                    "0",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Redeem(),
                                  ));
                            },
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding:
                                  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                  side: BorderSide(
                                      width: 1, color: Constants.blueGrey)),
                              backgroundColor: Colors.white,
                            ),
                            child: const DesignText(
                              'Redeem',
                              color: Constants.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                HomeCard(
                  svgImage: "assets/svg/refer.svg",
                  descrition:
                      "Invite your friends and femily to get  more coins",
                  title: "REFER FRIENDS",
                  backgroundColor: Constants.blueLite,
                ),
                const HomeCard2(
                  svgImage: "assets/svg/network.svg",
                  descrition: "Get all my network",
                  title: "MY NETWORK",
                  backgroundColor: Constants.green,
                ),
                const HomeCard2(
                  svgImage: "assets/svg/box.svg",
                  descrition: "Tap & get more coins",
                  title: "MEGA BOX",
                  backgroundColor: Constants.blueLite,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: ((context, index) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/box.svg",
                              height: 60,
                            ),
                            DesignText(
                              "Name",
                              color: Constants.blueDark,
                            ),
                          ],
                        ));
                      })),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DesignText(
                          "MORE OFFER",
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Constants.blueDark,
                        ),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
                        MoreOfferCard(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoreOfferCard extends StatelessWidget {
  const MoreOfferCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/money.svg",
                height: 55,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DesignText(
                      "Daily Scratch  - online job work",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4),
                    DesignText(
                      "Register and use app",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 2),
              TextButton(
                onPressed: () {},
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
                      side: BorderSide(width: 1, color: Constants.blueGrey)),
                  backgroundColor: Colors.white,
                ),
                child: const DesignText(
                  'Redeem',
                  color: Constants.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Divider(
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.title,
    required this.descrition,
    required this.svgImage,
    required this.backgroundColor,
  }) : super(key: key);
  final String title;
  final String descrition;
  final String svgImage;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(
                      title,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Constants.blueDark,
                    ),
                    const SizedBox(height: 6),
                    DesignText(
                      descrition,
                      color: Constants.blueDark,
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              svgImage,
              width: MediaQuery.of(context).size.width / 3,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard2 extends StatelessWidget {
  const HomeCard2({
    Key? key,
    required this.title,
    required this.descrition,
    required this.svgImage,
    required this.backgroundColor,
  }) : super(key: key);
  final String title;
  final String descrition;
  final String svgImage;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    svgImage,
                    height: 60,
                  ),
                  const SizedBox(width: 6),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DesignText(
                        title,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Constants.blueDark,
                      ),
                      const SizedBox(height: 6),
                      DesignText(
                        descrition,
                        color: Constants.blueDark,
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   static const String routeName = "HomePage";
//
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   static const playStoreUrl = Constants.appLink;
//   FirestoreServices fireStoreServices = FirestoreServices();
//
//   @override
//   void initState() {
//     try {
//       FirestoreServices().checkForUpdate(context);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
//     FirebaseMessaging.instance.subscribeToTopic("all");
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//       if (mounted) {
//         debugPrint("OnMessage: ${event.notification?.body}");
//       }
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       debugPrint("onLaunch: $message");
//       _navigateToItemDetail(message);
//     });
//     FirebaseMessaging.instance.getInitialMessage().then((value) {
//       debugPrint("GetInitialMessage: ${value?.notification?.body}");
//     });
//
//     super.initState();
//   }
//
//   void _navigateToItemDetail(message) {
//     final MessageBean item = _itemForMessage(message);
//     // Clear away dialogs
//     Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
//
//     if (item.itemId != "1") {
//       Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//         return const HomePage();
//       }));
//     }
//
//     if (!item.route.isCurrent) {
//       Navigator.push(context, item.route);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return pageUI();
//   }
//
//   Widget pageUI() {
//     var userData = Provider.of<UserStream>(context);
//     return Consumer<ConnectivityProvider>(
//       builder: (consumerContext, model, child) {
//         if (model.isOnline != null) {
//           if (model.isOnline!) {
//             return WillPopScope(
//               onWillPop: showExitPopup,
//               child: Scaffold(
//                 appBar: AppBar(
//                   elevation: 0,
//                   title: const Text(Constants.appBarTitle),
//                   actions: <Widget>[
//                     const SizedBox(
//                       width: 10,
//                     )
//                   ],
//                 ),
//                // body: const CoinPriceDashboardPage(),
//                  body: const HomeScreen(),
//                 drawer: Drawer(
//                   child: ListView(
//                     children: <Widget>[
//                       UserAccountsDrawerHeader(
//                         decoration: const BoxDecoration(
//                           color: Constants.dashboardContainerColor,
//                         ),
//                         accountName: const Text(
//                           Constants.appName,
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         accountEmail: Text(
//                           userData.email!.isNotEmpty ? userData.email! : "",
//                           style: const TextStyle(
//                               fontSize: 15, color: Colors.white),
//                         ),
//                         currentAccountPicture: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child: ClipOval(
//                             child: Image.network(
//                               userData.profilePhoto!.isNotEmpty
//                                   ? userData.profilePhoto!
//                                   : "",
//                               fit: BoxFit.cover,
//                               width: 100,
//                               height: 100,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       ListTile(
//                         title: const Text("Logout"),
//                         leading: const Icon(FontAwesomeIcons.signOutAlt),
//                         onTap: () {
//                           Navigator.of(context).pop();
//                           _signOut(context);
//                         },
//                       ),
//                       const Divider(
//                         height: 1,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return WillPopScope(
//                 onWillPop: () async {
//                   return await showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: const Text("Confirm Exit"),
//                           content: const Text(
//                               "Are you sure you want to exit? Instead You Can Switch your network On and use The App"),
//                           actions: <Widget>[
//                             ElevatedButton(
//                               child: const Text("YES"),
//                               onPressed: () {
//                                 SystemNavigator.pop();
//                               },
//                             ),
//                             ElevatedButton(
//                               child: const Text("NO"),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             )
//                           ],
//                         );
//                       });
//                 },
//                 child: const NoInternet());
//           }
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
//
//   Future<void> _signOut(BuildContext context) async {
//     ProgressDialog progressDialog = ProgressDialog(
//       context: context,
//       backgroundColor: Colors.grey,
//       textColor: Colors.white,
//     );
//
//     progressDialog.show();
//     var firebaseAuthServices = FirebaseAuthServices();
//
//     try {
//       firebaseAuthServices.signOutWhenGoogle();
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   Future<bool> showExitPopup() async {
//     return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text(
//               'Exit App',
//               textAlign: TextAlign.center,
//             ),
//             content: const Text(
//               'Do you really want to exit an App?',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 18, color: Colors.white, letterSpacing: 1.2),
//             ),
//             actionsAlignment: MainAxisAlignment.spaceEvenly,
//             actions: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(primary: Colors.red),
//                 onPressed: () => Navigator.of(context).pop(false),
//                 //return false when click on "NO"
//                 child: const Text(' No '),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(primary: Colors.red),
//                 onPressed: () => SystemNavigator.pop(),
//                 //return true when click on "Yes"
//                 child: const Text(' Yes '),
//               ),
//             ],
//           ),
//         ) ??
//         false; //if showDialouge had returned null, then return false
//   }
//
//   versionCheck(context) async {
//     //Get Current installed version of app
//     final PackageInfo info = await PackageInfo.fromPlatform();
//     double currentVersion =
//         double.parse(info.version.trim().replaceAll(".", ""));
//
//     //Get Latest version info from firebase config
//     final RemoteConfig remoteConfig = RemoteConfig.instance;
//
//     try {
//       // Using default duration to force fetching from remote server.
//       await remoteConfig.setConfigSettings(RemoteConfigSettings(
//         fetchTimeout: const Duration(seconds: 10),
//         minimumFetchInterval: Duration.zero,
//       ));
//       await remoteConfig.fetchAndActivate();
//       double newVersion = double.parse(remoteConfig
//           .getString(Constants.appVersionFromRemote)
//           .trim()
//           .replaceAll(".", ""));
//       if (newVersion == 10000) {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (_) => const AppShutPage()));
//       } else if (newVersion > currentVersion) {
//         _showVersionDialog(context);
//       }
//     } on PlatformException catch (exception) {
//       // Fetch throttled.
//       debugPrint(exception.toString());
//     } catch (exception) {
//       debugPrint(
//           'Unable to fetch remote config. Cached or default values will be used');
//     }
//   }
//
//   _showVersionDialog(context) async {
//     await showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         String title = "New Update Available";
//         String message =
//             "There is a newer version of this app in playstore available, We consider only claims from our latest version app, So update it now.";
//         String btnLabel = "Update Now";
//         return Platform.isIOS
//             ? CupertinoAlertDialog(
//                 title: Text(title),
//                 content: Text(message),
//                 actions: <Widget>[
//                   ElevatedButton(
//                     child: Text(btnLabel),
//                     onPressed: () => Tools.launchURL(playStoreUrl),
//                   ),
//                 ],
//               )
//             : AlertDialog(
//                 title: Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 content: Text(
//                   message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 actionsAlignment: MainAxisAlignment.center,
//                 actions: <Widget>[
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(primary: Colors.red),
//                     onPressed: () => Tools.launchURL(playStoreUrl),
//                     child: Text(btnLabel),
//                   ),
//                 ],
//               );
//       },
//     );
//   }
// }
//
// final Map<String, MessageBean> _items = <String, MessageBean>{};
//
// MessageBean _itemForMessage(Map<String, dynamic> message) {
//   //If the message['data'] is non-null, we will return its value, else return map message object
//   final dynamic data = message['data'] ?? message;
//   final String itemId = data['id'];
//   final MessageBean item = _items.putIfAbsent(itemId, () => MessageBean(itemId))
//     ..status = data['status'];
//   return item;
// }
//
// //Model class to represent the message return by FCM
// class MessageBean {
//   MessageBean(this.itemId);
//
//   final String itemId;
//
//   final StreamController<MessageBean> _controller =
//       StreamController<MessageBean>.broadcast();
//
//   Stream<MessageBean> get onChanged => _controller.stream;
//
//   String _status = "status";
//
//   String get status => _status;
//
//   set status(String value) {
//     _status = value;
//     _controller.add(this);
//   }
//
//   static final Map<String, Route<void>> routes = <String, Route<void>>{};
//
//   Route<void> get route {
//     final String routeName = '/detail/$itemId';
//     return routes.putIfAbsent(
//       routeName,
//       () => MaterialPageRoute<void>(
//         settings: RouteSettings(name: routeName),
//         builder: (BuildContext context) => DetailPage(
//           itemId: itemId,
//         ),
//       ),
//     );
//   }
// }
//
// //Detail UI screen that will display the content of the message return from FCM
// class DetailPage extends StatefulWidget {
//   final String itemId;
//
//   const DetailPage({Key? key, required this.itemId}) : super(key: key);
//
//   @override
//   _DetailPageState createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   MessageBean? _item;
//   StreamSubscription<MessageBean>? _subscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _item = _items[widget.itemId];
//     _subscription = _item!.onChanged.listen((MessageBean item) {
//       if (!mounted) {
//         _subscription!.cancel();
//       } else {
//         setState(() {
//           _item = item;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _subscription?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _item!.itemId == "1"
//             ? const Text("Payment Approved")
//             : const Text(""),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 100,
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.green),
//                 borderRadius: const BorderRadius.all(Radius.circular(10))),
//             child: CircleAvatar(
//               radius: 80,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset(
//                   Constants.coinImage,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           Center(
//               child: Text(
//             _item!.status,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.white),
//           )),
//         ],
//       ),
//     );
//   }
// }
