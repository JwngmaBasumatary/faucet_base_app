import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:ntp/ntp.dart';
import '../models/country.dart';
import '../models/general_data_model.dart';
import '../models/user_basic_model.dart';
import '../models/user_stream.dart';
import '../models/users.dart';
import '../dashboard/home_page.dart';
import '../screens/update_screen.dart';
import '../utils/constants.dart';
import '../utils/tools.dart';
import '../widgets/message_dialog_with_ok.dart';

class FirestoreServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// //////////////// New Firestore Service //////////////// ///

  /// Users ///

  //Top Users
  static Future<QuerySnapshot> getNewTopUsers(int limit,
      {DocumentSnapshot? startAfter}) async {
    final refUsers = FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .orderBy("uid")
        .limit(limit);
    return refUsers.get();
  }

  //Get User Name
  Future getName() async {
    final user = auth.currentUser;
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get('name'));
  }


  //User Basic Info
  Future<UserBasicModel> getUserBasicInfo() async {
    final user = auth.currentUser;
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) =>
            UserBasicModel.fromMap(documentSnapshot.data()!));
  }

  //Refresh User Account
  Future refreshUserAccount() async {
    final user = auth.currentUser;
    DateTime ntpDT = await NTP.now();
    var map = <String, dynamic>{};
    map['today'] = ntpDT.day;
    map['goldScratchTimer'] = FieldValue.serverTimestamp();
    map['silverScratchTimer'] = FieldValue.serverTimestamp();
    map['basicScratchTimer'] = FieldValue.serverTimestamp();
    map['diamondScratchTimer'] = FieldValue.serverTimestamp();
    map['diamondScratchLeft'] = 50;
    map['nextPayment'] = FieldValue.serverTimestamp();
    map['referralId'] = "";
    map['lastLogin'] = FieldValue.serverTimestamp();
    map['createdOn'] = FieldValue.serverTimestamp();
    await FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .update(map)
        .then((value) {
      Tools.showDebugPrint("The Account has been refreshed");
    }).catchError((error) {
      Tools.showToasts("Error $error");
    });
  }

  Future<bool> checkIfUserIsBlocked(String email, String coinbase) async {
    bool isBlocked = false;
    final user = auth.currentUser;

    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collBlockedUsers)
        .doc(user!.uid)
        .get()
        .then((value) {
      isBlocked = value.exists;
    });

    return isBlocked;
  }

  Stream<UserStream> getUserData(String uid) {
    return _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(uid)
        .snapshots()
        .map((event) => UserStream.fromMap(event.data()!));
  }

  Future<Users> getReferredUserProfile(String referredUid) async {
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(referredUid)
        .get()
        .then((documentSnapshot) => Users.fromMap(documentSnapshot.data()!));
  }

  /////////////////////////////////////////////////////////////////////

  /// Payments ///

  //Set Next Payment
  Future setNextPayment() async {
    final user = auth.currentUser;
    await FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user?.uid)
        .set({
      'nextPayment': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)).then(
            (_) => debugPrint("Next Payment is set!!!"));
  }

  //Withdraw

  Future<bool> addWithdrawRequestInBatch(
      BuildContext context,
      String method,
      int points,
      int successClaims,
      String walletAddress,
      Timestamp lastWithdrawalTime,
      int clicks,
      String referredBy,
      String country, String idToken) async {
    DateTime ntpDT = await NTP.now();
    bool hasWithdrawn = false;
    final user = auth.currentUser;

    var withdrawMap = <String, dynamic>{};
    withdrawMap["points"] = points;
    withdrawMap["successClaims"] = successClaims;
    withdrawMap["time"] = FieldValue.serverTimestamp();
    withdrawMap["method"] = method;
    withdrawMap["status"] = "pending";
    withdrawMap["referredBy"] = referredBy;
    withdrawMap["walletAddress"] = walletAddress;
    withdrawMap["uid"] = user!.uid;
    withdrawMap["lastWithdrawal"] = lastWithdrawalTime;
    withdrawMap["title"] = "Withdrawal to ${method.toLowerCase()}";
    withdrawMap["clicks"] = clicks;
    withdrawMap["country"] = country;
    withdrawMap["version"] = Constants.releaseVersionCode;
    withdrawMap["symbol"] = Constants.symbol;
    withdrawMap["appName"] = Constants.appName;
    withdrawMap["idToken"] = idToken;
    withdrawMap["isValidRequest"] =
        ntpDT.compareTo(lastWithdrawalTime.toDate());
    String docId = user.uid + Timestamp.now().toDate().toIso8601String();

    var updateUserMap = <String, dynamic>{};
    updateUserMap["points"] = 0;
    updateUserMap["clicks"] = 0;
    updateUserMap["successClaims"] = FieldValue.increment(1);
    updateUserMap["lastWithdrawal"] = ntpDT;
    updateUserMap["nextPayment"] =
        Timestamp.fromDate(ntpDT.add(const Duration(hours: 24)));

    WriteBatch batch = FirebaseFirestore.instance.batch();

    ///Write in Withdraw_Requests
    batch.set(
        _db
            .collection(Constants.appCoinName)
            .doc(Constants.docAppNumber)
            .collection(Constants.collWithdrawRequests)
            .doc(docId),
        withdrawMap);

    ///Write in Transactions
    batch.set(
        _db
            .collection(Constants.appCoinName)
            .doc(Constants.docAppNumber)
            .collection(Constants.collUsers)
            .doc(user.uid)
            .collection(Constants.subCollTransactions)
            .doc(docId),
        withdrawMap);

    // ///Write in Users
    batch.update(
        _db
            .collection(Constants.appCoinName)
            .doc(Constants.docAppNumber)
            .collection(Constants.collUsers)
            .doc(user.uid),
        updateUserMap);

    /////Testing
    // var dummyUpdateUserMap = <String, dynamic>{};
    // dummyUpdateUserMap["points"] = FieldValue.increment(10);
    // batch.update(
    //     _db
    //         .collection(Constants.appCoinName)
    //         .doc(Constants.docAppNumber)
    //         .collection(Constants.collUsers)
    //         .doc(user.uid),
    //     dummyUpdateUserMap);

    await batch.commit().then((value) async {
      hasWithdrawn = true;
    }).catchError((error) {
      Tools.showDebugPrint("Error: ${error.toString()}");
    });

    return hasWithdrawn;
  }

  Future addWalletAddress(Map<String, dynamic> data) async {
    final user = auth.currentUser;

    await FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .set(data, SetOptions(merge: true))
        .then((_) => debugPrint('Wallet address successfully loaded'))
        .catchError((error) {
      debugPrint("Error for write $error");
      Tools.showToasts("Error $error");
    });
  }

  Future getNextPaymentDate() async {
    final user = auth.currentUser;
    debugPrint("Get nextPayment is called");
    Timestamp nextPaymentDateExist = await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get('nextPayment'));

    if (nextPaymentDateExist.toString().isNotEmpty) {
      return nextPaymentDateExist.millisecondsSinceEpoch;
    } else {
      return 0;
    }
  }


  /// Events ///

  ///Scratch
  Future<int> getIntFieldValue(String docName) async {
    final user = auth.currentUser;
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get(docName));
  }

  Future addToday() async {
    final user = auth.currentUser;
    DateTime ntpDT = await NTP.now();
    var map = <String, dynamic>{};
    map['spinsLeft'] = Constants.dailyClicksAvailable;
    map['basicScratchLeft'] = Constants.dailyClicksAvailable;
    map['silverScratchLeft'] = Constants.dailyClicksAvailable;
    map['goldScratchLeft'] = Constants.dailyClicksAvailable;
    map['diamondScratchLeft'] = Constants.dailyClicksAvailable;
    map['numberGameLeft'] = Constants.dailyClicksAvailable;
    map['today'] = ntpDT.day;
    map['version'] = Constants.releaseVersionCode;
    await FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .set(map, SetOptions(merge: true))
        .then((value) {
      debugPrint("The Date  and Clicks Left is Updated");
    }).catchError((error) {
      debugPrint("Error for write $error");
      Tools.showToasts("Error $error");
    });
  }

  //add points
  Future<bool> addPointsForAction(
    int points,
    String title,
    String clicksLeft,
    int nextClickTime,
  ) async {
    DateTime ntpDT = await NTP.now();
    bool finalVal = false;
    final user = auth.currentUser;
    var map = <String, dynamic>{};
    map['points'] = points;
    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .update({
      "points": FieldValue.increment(points),
      "clicks": FieldValue.increment(1),
      clicksLeft: FieldValue.increment(-1),
    }).then((value) async {
      var nextClaimMap = <String, dynamic>{};
      nextClaimMap[title] =
          Timestamp.fromDate(ntpDT.add(Duration(minutes: nextClickTime)));
      await _db
          .collection(Constants.appCoinName)
          .doc(Constants.docAppNumber)
          .collection(Constants.collUsers)
          .doc(user.uid)
          .update(nextClaimMap)
          .then((value) {
        finalVal = true;
      });
    }).catchError((error) {
      debugPrint("Error for write $error");
      // Tools.showToasts("Error $error");
    });
    return finalVal;
  }

  ///Miscellaneous
  Future<bool> addPaymentScreenshotImage(
    String url,
  ) async {
    bool imageUploaded = false;
    final user = auth.currentUser;

    var paymentProofMap = <String, dynamic>{};
    paymentProofMap["uid"] = user!.uid;
    paymentProofMap["url"] = url;
    paymentProofMap["status"] = "pending";
    paymentProofMap["time"] = FieldValue.serverTimestamp();

    var eventExist = await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collPaymentProofs)
        .doc(user.uid)
        .get();

    if (!eventExist.exists) {
      await _db
          .collection(Constants.appCoinName)
          .doc(Constants.docAppNumber)
          .collection(Constants.collPaymentProofs)
          .doc(user.uid)
          .set(paymentProofMap)
          .then((value) {
        imageUploaded = true;
      });
      return imageUploaded;
    } else {
      return imageUploaded;
    }
  }

  Future<bool> addFaucetPayReviewScreenshotImage(
    String url,
  ) async {
    bool imageUploaded = false;
    final user = auth.currentUser;

    var paymentProofMap = <String, dynamic>{};
    paymentProofMap["uid"] = user!.uid;
    paymentProofMap["url"] = url;
    paymentProofMap["status"] = "pending";
    paymentProofMap["time"] = FieldValue.serverTimestamp();

    var eventExist = await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collFaucetPayProofs)
        .doc(user.uid)
        .get();

    if (!eventExist.exists) {
      await _db
          .collection(Constants.appCoinName)
          .doc(Constants.docAppNumber)
          .collection(Constants.collFaucetPayProofs)
          .doc(user.uid)
          .set(paymentProofMap)
          .then((value) {
        imageUploaded = true;
      });
      return imageUploaded;
    } else {
      return imageUploaded;
    }
  }

  Future<bool> addImage(
    String url,
  ) async {
    bool imageUploaded = false;
    final user = auth.currentUser;

    var subscribersMap = <String, dynamic>{};
    subscribersMap["uid"] = user!.uid;
    subscribersMap["url"] = url;
    subscribersMap["status"] = "pending";
    subscribersMap["time"] = FieldValue.serverTimestamp();

    var eventExist = await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collSubscribers)
        .doc(user.uid)
        .get();

    if (!eventExist.exists) {
      await _db
          .collection(Constants.appCoinName)
          .doc(Constants.docAppNumber)
          .collection(Constants.collSubscribers)
          .doc(user.uid)
          .set(subscribersMap)
          .then((value) {
        imageUploaded = true;
      });
      return imageUploaded;
    } else {
      return imageUploaded;
    }
  }

  ///Login Bonus
  // get next daily login bonus
  Future<bool> setNextDailyLoginBonus(points) async {
    bool claimSuccess = false;

    DateTime ntpDT = await NTP.now();
    final user = auth.currentUser;
    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user?.uid)
        .set(
      {
        "nextDailyLoginBonus": Timestamp.fromDate(
          ntpDT.add(
            const Duration(hours: 24),
          ),
        ),
        "points": FieldValue.increment(points),
      },
      SetOptions(merge: true),
    ).then((value) {
      claimSuccess = true;
    });

    return claimSuccess;
  }

  // get next daily login bonus
  Future<int?> getNextDailyLoginBonus() async {
    int? nextloginBonus;
    final user = auth.currentUser;
    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> docDataMap = value.data() as Map<String, dynamic>;

        if (docDataMap.containsKey('nextDailyLoginBonus')) {
          debugPrint('nextDailyLoginBonus ${value['nextDailyLoginBonus']}');
          nextloginBonus = value['nextDailyLoginBonus'].millisecondsSinceEpoch;
        }
      }
    });

    return nextloginBonus;
  }

  /////////////////////////////////////////////////////////////////////

  ///Spinner
  //Set Spins Left
  Future<bool> setSpinsLeft() async {
    bool spinLeftAdded = false;
    final user = auth.currentUser;
    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user?.uid)
        .set({"spinsLeft": Constants.totalSpins}, SetOptions(merge: true)).then(
            (value) {
      spinLeftAdded = true;
      Tools.showDebugPrint("spin left added to old users!!");
    }).catchError((err) {
      Tools.showDebugPrint(
          "Some error has occurred on set of spin left!! error code : $err");
    });

    return spinLeftAdded;
  }

  //Get Spins Left
  Future<int?> getSpinsLeft(String fieldName) async {
    int? eventClicksLeft;
    final user = auth.currentUser;
    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> docDataMap = value.data() as Map<String, dynamic>;

        if (docDataMap.containsKey(fieldName)) {
          debugPrint('fieldName ${value[fieldName]}');
          eventClicksLeft = value[fieldName];
        }
      }
    });

    return eventClicksLeft;
  }

  //Get Next Event Time
  Future<int?> getNextEventTime(String fieldName) async {
    int? nextEventTime;
    final user = auth.currentUser;
    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> docDataMap = value.data() as Map<String, dynamic>;

        if (docDataMap.containsKey(fieldName)) {
          debugPrint('eventName ${value[fieldName]}');
          nextEventTime = value[fieldName].millisecondsSinceEpoch;
        }
      }
    });

    return nextEventTime;
  }

  ///Weekly Event

  Future<void> participate(String week, context) async {
    final user = auth.currentUser;
    var doc1Ref = _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collWeeklyEvent)
        .doc(
            "${Timestamp.now().toDate().year.toString()}_${Timestamp.now().toDate().month.toString()}");
    var doc2Ref = doc1Ref.collection("${week}_Participants").doc(user!.uid);

    var participantsExist = await doc2Ref.get();

    if (!participantsExist.exists) {
      doc2Ref.set({
        "uid": user.uid,
        "name": user.displayName,
        "email": user.email,
      }).then((_) => {
            doc1Ref.set({
              "total${week.split("_").join('')}Participants":
                  FieldValue.increment(1)
            }).then((_) {
              showDialog(
                  context: context,
                  builder: (context) => const CustomDialogWithOk(
                        title: "Participated Successfully",
                        description:
                            "You have participated in the Weekly Give Away. Result Will be Declared in our Telegram Group",
                        primaryButtonText: "Ok",
                        primaryButtonRoute: HomePage.routeName,
                      ));
            })
          });
    } else {
      showDialog(
          context: context,
          builder: (context) => const CustomDialogWithOk(
                title: "Already Participated",
                description:
                    "You have already participated in the Weekly Give Away",
                primaryButtonText: "Ok",
                primaryButtonRoute: HomePage.routeName,
              ));
      Tools.showDebugPrint("participant already exist!!");
    }
  }

  //Get Give Away Winners
  Future<List<DocumentSnapshot>> getGiveAwayWinners() async {
    List<DocumentSnapshot> list = [];
    Query query = _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collWeeklyGiveAwayWinners)
        .orderBy("time", descending: false);
    QuerySnapshot querySnapshot = await query.get();
    list = querySnapshot.docs;

    return list;
  }

  /////////////////////////////////////////////////////////////////////



  ///Check For App update
  Future checkForUpdate(BuildContext context) async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        Tools.showDebugPrint("Updates Available");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UpdateScreen()));
      } else {
        Tools.showDebugPrint("No New App Version Updates Available");
      }
    }).catchError((e) {
      Tools.showDebugPrint(e.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////

  ///Referral
  Future setReferralLink(String refLink) async {
    final user = auth.currentUser;
    var referalMap = <String, dynamic>{};
    referalMap['referralId'] = refLink;
    await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .update(referalMap);
  }



// NextPayment Data Type (Int or Timestamp)
  Future<bool> checkFieldDataType(field) async {
    final user = auth.currentUser;
    debugPrint("Get nextPayment is called");
    var nextPaymentDateExist = await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get(field));

    debugPrint('DataType is int: ${nextPaymentDateExist is int}');

    if (nextPaymentDateExist.toString().isNotEmpty) {
      if (nextPaymentDateExist is Timestamp) {
        return false;
      } else if (nextPaymentDateExist is int) {
        return true;
      }
    } else {
      return true;
    }
    return true;
  }

  //Check already Present
  Future<bool> checkIfAddedAlready(String collectionName) async {
    final user = auth.currentUser;
    var eventExist = await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(collectionName)
        .doc(user!.uid)
        .get();

    if (!eventExist.exists) {
      return false;
    } else {
      return true;
    }
  }

  //Set Notification Seen
  Future setNotificationSeen() async {
    debugPrint("Set Notification is Running");
    final user = auth.currentUser;
    var notificationMap = <String, dynamic>{};
    notificationMap["newNotification"] = 0;
    _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user?.uid)
        .update(notificationMap)
        .then((value) {
      debugPrint("Set Notification is Running -- Done");
    });
  }

  // getting Notifications
  getNotifications() async {
    final user = auth.currentUser;
    return _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .collection(Constants.subCollNotifications)
        .orderBy("time", descending: false)
        .snapshots();
  }

  // getting Notifications
  getAnnouncements() async {
    return _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collAnnouncements)
        // .orderBy("time", descending: false)
        .snapshots();
  }

  //General Info
  Stream<GeneralDataModel> getGeneralData() {
    return _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .snapshots()
        .map((event) => GeneralDataModel.fromMap(event.data()!));
  }

  //Api Fetch Country
  Future<String?> getCountryForSignup() async {
    String url = "http://ip-api.com/json";
    var response = await http.get(
      Uri.parse(url),
    );
    var jsonResponse = json.decode(response.body);
    // debugPrint(jsonResponse);
    return Country.fromJson(jsonResponse).country;
  }

  //Get Email
  Future<String> getEmail() async {
    final user = auth.currentUser;
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get('email'));
  }

  //Get UID
  Future getCurrentUid() async {
    final user = auth.currentUser;
    return user!.uid.toString();
  }


  Future getToday() async {
    debugPrint("Get Today  is Called");
    final user = auth.currentUser;
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get('today'));
  }

  Future<String> getFieldValue(String docName) async {
    final user = auth.currentUser;
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get(docName));
  }

  Future<Timestamp> getTimeStampFieldValue(String docName) async {
    final user = auth.currentUser;
    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .get()
        .then((documentSnapshot) => documentSnapshot.get(docName));
  }

  //Refresh Account

  Future refreshAccount() async {
    final user = auth.currentUser;
    DateTime ntpDT = await NTP.now();
    var map = <String, dynamic>{};
    map['today'] = ntpDT.day;
    map['goldScratchTimer'] = FieldValue.serverTimestamp();
    map['silverScratchTimer'] = FieldValue.serverTimestamp();
    map['basicScratchTimer'] = FieldValue.serverTimestamp();
    map['diamondScratchTimer'] = FieldValue.serverTimestamp();
    map['diamondScratchLeft'] = 50;
    map['nextPayment'] = FieldValue.serverTimestamp();
    map['referralId'] = "";
    map['lastLogin'] = FieldValue.serverTimestamp();
    map['createdOn'] = FieldValue.serverTimestamp();
    map['accountReset'] = false;

    DocumentReference docRef = FirebaseFirestore.instance
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid);

    await docRef.set(map, SetOptions(merge: true)).then((value) {
      Tools.showDebugPrint("The Account has been refreshed");
    }).catchError((error) {
      Tools.showDebugPrint("$error");

      Tools.showToasts("Error $error");
    });
  }

  ///First time Address Saved

  Future addSingleWalletAddress(data) async {
    final user = auth.currentUser;

    return await _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user!.uid)
        .set(data, SetOptions(merge: true));
  }

  Stream fetchReferredUsers() {
    final user = auth.currentUser!;
    return _db
        .collection(Constants.appCoinName)
        .doc(Constants.docAppNumber)
        .collection(Constants.collUsers)
        .doc(user.uid)
        .collection(Constants.referral)
        .orderBy("createdOn", descending: false)
        .limit(30)
        .snapshots();
  }

}
