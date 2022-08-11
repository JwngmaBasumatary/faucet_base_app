import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/home_page.dart';
import '../providers/common_providers.dart';
import '../screens/splash_screen_page.dart';
import '../services/dynamic_links_services.dart';
import '../services/firebase_auth_services.dart';
import '../utils/constants.dart';
import 'auth_widget_builder.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final DynamicServices _dynamicServices = DynamicServices();

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  void initDynamicLinks() async {
    await _dynamicServices.handleDynamicLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<CommonProviders>(
                create: (_) => CommonProviders()),
            Provider<FirebaseAuthServices>(
                create: (_) => FirebaseAuthServices())
          ],
          child: Provider<FirebaseAuthServices>(
            create: (_) => FirebaseAuthServices(),
            child: AuthWidgetBuilder(builder: (context, userSnapshot) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  builder: BotToastInit(),
                  //1. call BotToastInit
                  navigatorObservers: [BotToastNavigatorObserver()],
                  theme: ThemeData(
                    backgroundColor: Constants.dashboardContainerColor,
                    appBarTheme: const AppBarTheme(
                        backgroundColor: Constants.dashboardContainerColor,
                        foregroundColor: Colors.white),
                    primarySwatch: const MaterialColor(4280361249, {
                      50: Color(0xfff2f2f2),
                      100: Color(0xffe6e6e6),
                      200: Color(0xffcccccc),
                      300: Color(0xffb3b3b3),
                      400: Color(0xff999999),
                      500: Color(0xff808080),
                      600: Color(0xff666666),
                      700: Color(0xff4d4d4d),
                      800: Color(0xff333333),
                      900: Color(0xff191919)
                    }),
                    inputDecorationTheme: const InputDecorationTheme(
                      labelStyle: TextStyle(color: Colors.red),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    brightness: Brightness.dark,
                    primaryColor: const Color(0xff212121),
                    primaryColorLight: const Color(0xff9e9e9e),
                    primaryColorDark: const Color(0xff000000),
                   //scaffoldBackgroundColor: const Color(0xffdedede)
                  ),
                  //2. registered route observer
                  routes: {
                    HomePage.routeName: (context) => const HomePage(),

                  },
                  home: SplashScreenPage(userSnapshot: userSnapshot));
            }),
          ),
        );
      },
    );
  }
}
