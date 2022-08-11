import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users.dart';
import '../providers/common_providers.dart';
import '../services/firestore_services.dart';
import '../utils/constants.dart';
import '../utils/tools.dart';

@immutable
class User {
  final String uid;

  const User({required this.uid});
}

class FirebaseAuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirestoreServices firestoreServices = FirestoreServices();

  Users? users;

  User _userFromFirebase(user) {
    return User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future signInWithGoogle(
      BuildContext context, CommonProviders commonProvider) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Tools.showDebugPrint("Error in catch $e");
      commonProvider
          .setLoginError("You have Encountered Error While Logging In");
      commonProvider.setIsLoading();
    }
  }

  // create user with email and password
  Future createAccountWithEmailAndPassword(String email, String password,
      BuildContext context, CommonProviders commonProvider) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed with error code: ${e.code}');
      debugPrint(e.message);
      commonProvider
          .setLoginError("You have Encounterred Error While Logging In");
      commonProvider.setIsLoading();
    }
  }

  // Sign user with email and password
  Future signInUserWithWithEmailAndPassword(String email, String password,
      BuildContext context, CommonProviders commonProvider) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed with error code: ${e.code}');
      debugPrint(e.message);
      commonProvider
          .setLoginError("You have Encounterred Error While Logging In");
      commonProvider.setIsLoading();
    }
  }

  //send reset password Link
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<bool> checkIfUserAlreadyExist(UserCredential firebaseUser) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constants.appCoinName) // new db struct
        .doc(Constants.docAppNumber) // new db struct
        .collection(Constants.collUsers)
        .where("email", isEqualTo: firebaseUser.user?.email)
        .get();

    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection(Constants.users)
    //     .where("email", isEqualTo: firebaseUser.user?.email)
    //     .get();

    List<DocumentSnapshot> docs = querySnapshot.docs;

    debugPrint("Doc Length (Email check  ${docs.length}");

    return docs.isNotEmpty ? false : true;
  }

  //sign out the user , when logged in with google auth
  Future signOutWhenGoogle() async {
    debugPrint("Logout Called");
    bool isGoogleSignedIn = await _googleSignIn.isSignedIn();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (isGoogleSignedIn) {
      sharedPreferences.clear();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      return await _firebaseAuth.signOut();
    } else {
      sharedPreferences.clear();
      return _firebaseAuth.signOut();
    }
  }

  Future<void> updateIdToken(UserCredential currentuser) async {
    var firebaseMessageing = FirebaseMessaging.instance;

    String? token = await firebaseMessageing.getToken();
    debugPrint(" The New id Token -$token");
    var map = <String, dynamic>{};
    map['idToken'] = token;
    map['today'] = Timestamp.now().toDate().day;
    map['lastLogin'] = FieldValue.serverTimestamp();
    map["version"] = Constants.releaseVersionCode;

    await FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(currentuser.user?.uid)
        .update(map);
  }

  Future<void> updateUserProfile(Users users) async {
    var map = <String, dynamic>{};
    map["name"] = users.name;
    map["email"] = users.email;
    await FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(users.uid)
        .update(map);
  }

////////////////////////// New Auth Functions //////////////////////

  Future<void> addToNewDb(UserCredential currentUser, String refId) async {
    var firebaseMessaging = FirebaseMessaging.instance;

    String? token = await firebaseMessaging.getToken();
    String country =
        await firestoreServices.getCountryForSignup().then((value) => value!);

    DateTime ntpDT = await NTP.now();

    debugPrint("The Country of the new User is $country");
    debugPrint(" Your id Token -$token");

    users = Users(
      uid: currentUser.user?.uid,
      email: currentUser.user?.email,
      name: currentUser.user?.displayName,
      points: 0,
      newNotification: 0,
      idToken: token,
      clicks: 0,
      goldScratchTimer: Timestamp.fromDate(
          ntpDT.subtract(const Duration(minutes: Constants.claimTimer))),
      diamondScratchTimer: Timestamp.fromDate(
          ntpDT.subtract(const Duration(minutes: Constants.claimTimer))),
      successClaims: 0,
      silverScratchTimer: Timestamp.fromDate(
          ntpDT.subtract(const Duration(minutes: Constants.claimTimer))),
      basicScratchTimer: Timestamp.fromDate(
          ntpDT.subtract(const Duration(minutes: Constants.claimTimer))),
      nextSpinTime: Timestamp.fromDate(
          ntpDT.subtract(const Duration(minutes: Constants.spinClaimTimer))),
      nextNumberGameTime: Timestamp.fromDate(
          ntpDT.subtract(const Duration(minutes: Constants.spinClaimTimer))),
      basicScratchLeft: Constants.totalScratch,
      diamondScratchLeft: Constants.totalScratch,
      silverScratchLeft: Constants.totalScratch,
      goldScratchLeft: Constants.totalScratch,
      spinsLeft: Constants.totalSpins,
      numberGameLeft: Constants.totalNumberGame,
      today: ntpDT.day,
      claimed: 0,
      nextPayment: Timestamp.now(),
      lastWithdrawal:
          Timestamp.fromDate(ntpDT.subtract(const Duration(hours: 25))),
      referralId: "",
      version: Constants.releaseVersionCode,
      referredBy: refId,
      earnedByReferral: 0,
      lastLogin: Timestamp.now(),
      createdOn: Timestamp.now(),
      country: country,
      status: true,
      profilePhoto: currentUser.user?.photoURL,
      accountReset: false,
    );

    var userMap = <String, dynamic>{};
    userMap['uid'] = users?.uid;
    userMap['email'] = users?.email;
    userMap['name'] = users?.name;
    userMap['points'] = users?.points;
    userMap['newNotification'] = users?.newNotification;
    userMap['idToken'] = users?.idToken;
    userMap['clicks'] = users?.clicks;
    userMap['successClaims'] = users?.successClaims;
    userMap['basicScratchTimer'] = users?.basicScratchTimer;
    userMap['silverScratchTimer'] = users?.silverScratchTimer;
    userMap['goldScratchTimer'] = users?.goldScratchTimer;
    userMap['diamondScratchTimer'] = users?.diamondScratchTimer;
    userMap['nextSpinTime'] = users?.nextSpinTime;
    userMap['nextNumberGameTime'] = users?.nextNumberGameTime;
    userMap['basicScratchLeft'] = users?.basicScratchLeft;
    userMap['silverScratchLeft'] = users?.silverScratchLeft;
    userMap['goldScratchLeft'] = users?.goldScratchLeft;
    userMap['diamondScratchLeft'] = users?.diamondScratchLeft;
    userMap['spinsLeft'] = users?.spinsLeft;
    userMap['numberGameLeft'] = users?.numberGameLeft;
    userMap['today'] = users?.today;
    userMap['claimed'] = users?.claimed;
    userMap['nextPayment'] = users?.nextPayment;
    userMap['lastWithdrawal'] = users?.lastWithdrawal;
    userMap['referralId'] = users?.referralId;
    userMap['version'] = users?.version;
    userMap['referredBy'] = users?.referredBy;
    userMap['earnedByReferral'] = users?.earnedByReferral;
    userMap['lastLogin'] = users?.lastLogin;
    userMap['createdOn'] = users?.createdOn;
    userMap['country'] = users?.country;
    userMap['profilePhoto'] = users?.profilePhoto;
    userMap['accountReset'] = users?.accountReset;

    var referralMap = <String, dynamic>{};
    referralMap['name'] = currentUser.user?.displayName;
    referralMap['email'] = currentUser.user?.email;
    referralMap['uid'] = currentUser.user?.uid;
    referralMap['profilePhoto'] = currentUser.user?.photoURL;
    referralMap['createdOn'] = FieldValue.serverTimestamp();

    var totalUserMaps = <String, dynamic>{};
    totalUserMaps['users'] = FieldValue.increment(1);
    var userWelcomeNotificationMap = <String, dynamic>{};
    userWelcomeNotificationMap['title'] = "Welcome ${users?.name}";
    userWelcomeNotificationMap['message'] =
        "Congratulations ${users?.name} on Creating Account at ${Constants.appName} App. You Just joined a ${Constants.appName} , the community for ${Constants.coinName} Faucets. Now Claim your ${Constants.coinName} and enjoy the App .";
    userWelcomeNotificationMap['time'] = Timestamp.now()
        .toDate()
        .add(const Duration(minutes: 5))
        .toIso8601String();
    if (refId != "") {
      ///With Referral

      ///Add User Data
      await FirebaseFirestore.instance
          .collection(Constants.appCoinName) // new db struct
          .doc(Constants.docAppNumber) // new db struct
          .collection(Constants.collUsers)
          .doc(currentUser.user?.uid)
          .set(userMap)
          .then((value) async {
        Tools.showDebugPrint("User Added to DB");

        ///Add General Informations
        await FirebaseFirestore.instance
            .collection(Constants.appCoinName) // new db struct
            .doc(Constants.docAppNumber) // new db struct
            // .collection(Constants.generalInformations)
            // .doc("generalInformations")
            .set(totalUserMaps, SetOptions(merge: true))
            .then((value) async {
          Tools.showDebugPrint("General info Added");

          ///Add Notifications
          await FirebaseFirestore.instance
              .collection(Constants.appCoinName) // new db struct
              .doc(Constants.docAppNumber) // new db struct
              .collection(Constants.collUsers)
              .doc(currentUser.user?.uid)
              .collection(Constants.subCollNotifications)
              .doc()
              .set(userWelcomeNotificationMap)
              .then((value) async {
            Tools.showDebugPrint("Notification info Added");

            ///Add Notifications
            await FirebaseFirestore.instance
                .collection(Constants.appCoinName) // new db struct
                .doc(Constants.docAppNumber) // new db struct
                .collection(Constants.collUsers)
                .doc(refId)
                .collection("Referral")
                .doc(currentUser.user?.uid)
                .set(referralMap);
          });
        });
      });
    } else {
      ///Without Referral

      await FirebaseFirestore.instance
          .collection(Constants.appCoinName) // new db struct
          .doc(Constants.docAppNumber) // new db struct
          .collection(Constants.collUsers)
          .doc(currentUser.user?.uid)
          .set(userMap)
          .then((value) async {
        Tools.showDebugPrint("User Added to DB");

        ///Add General Informations
        await FirebaseFirestore.instance
            // .collection(Constants.generalInformations)
            // .doc("generalInformations")
            .collection(Constants.appCoinName) // new db struct
            .doc(Constants.docAppNumber) // new db struct
            .set(totalUserMaps, SetOptions(merge: true))
            .then((value) async {
          Tools.showDebugPrint("General info Added");

          ///Add Notifications
          await FirebaseFirestore.instance
              .collection(Constants.appCoinName) // new db struct
              .doc(Constants.docAppNumber) // new db struct
              .collection(Constants.collUsers)
              .doc(currentUser.user?.uid)
              .collection(Constants.subCollNotifications)
              .doc()
              .set(userWelcomeNotificationMap);
        });
      });
    }
  }
}
