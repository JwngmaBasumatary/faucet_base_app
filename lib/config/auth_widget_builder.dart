import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/general_data_model.dart';
import '../models/user_stream.dart';
import '../providers/common_providers.dart';
import '../providers/connectivity_provider.dart';
import '../dashboard/home_page.dart';
import '../services/firebase_auth_services.dart';
import '../services/firestore_services.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Auth Widget Builder");
    final authServices = FirebaseAuthServices();
    FirestoreServices firestoreServices = FirestoreServices();

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return StreamBuilder<User>(
            stream: authServices.onAuthStateChanged,
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (user != null) {
                return MultiProvider(
                  providers: [
                    Provider<User>.value(
                      value: user,
                    ),
                    Provider<FirestoreServices>(
                      create: (_) => FirestoreServices(),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => ConnectivityProvider(),
                      child: const HomePage(),
                    ),
                    ChangeNotifierProvider<CommonProviders>(
                        create: (_) => CommonProviders()),
                    StreamProvider(
                      create: (BuildContext context) =>
                          firestoreServices.getUserData(user.uid),
                      initialData: UserStream(
                        points: 0,
                        email: "",
                        profilePhoto: "",
                        newNotification: 0,
                        nextPayment: Timestamp.now(),
                        basicScratchTimer: Timestamp.now(),
                        silverScratchTimer: Timestamp.now(),
                        goldScratchTimer: Timestamp.now(),
                        diamondScratchTimer: Timestamp.now(),
                        accountReset: false,
                      ),
                    ),
                    StreamProvider(
                      create: (BuildContext context) =>
                          firestoreServices.getGeneralData(),
                      initialData: GeneralDataModel(
                          users: 10000,
                          lastNotified: Timestamp.now(),
                          blocked: false,
                          appVersion: 1,
                          appStatus: true,
                          newApp: "",
                          withdrawStatus: true),
                    ),
                  ],
                  child: builder(context, snapshot),
                );
              }
              return builder(context, snapshot);
            });
      },
    );
  }
}
