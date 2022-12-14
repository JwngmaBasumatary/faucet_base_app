import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Constants {
  static List<String> withdrawalServices = [
    "Coinbase",
    //"FaucetPay",
  ];

  //Config Main Colors

  static const Color dashboardContainerColor = Color(0xff10263C);
  static const Color dbContainerTitleColor = Colors.white;
  static const blue = Color(0xff287FCD);
  static const blueDark = Color(0xff154A76);
  static const blueBg = Color(0xffF4F3F8);
  static const blueLiteBg = Color(0xffF8F9FE);
  static const blueGrey = Color(0xffCBD1D7);
  static const blueLite = Color(0xffA7E8FE);
  static const green = Color(0xff35A694);
  //Text required for app
  static const String appName = "Cloud Cardano Faucet";
  static const String appBarTitle = "Cardano Faucet";
  static const String coinName = "Cardano";
  static const String symbol = "ADA";
  static const int releaseVersionCode = 3;
  static const String packageName = "com.cloudadafaucet.cloud_cardano_faucet";
  static const String email = "faucetapps2021@gmail.com";
  static const String appOwnerName = "Golapi Basumatary";
  static const String coingekoNetworkName = "cardano";
  static const String appSource = kReleaseMode ? "Play Store" : "Local Source";


  //for dynamic link
  static const String firebaseDynamicUrl = "https://cardanofaucetapp.page.link";
  static const String telegramGroupLink =
      "https://t.me/coinbasefaucets";
  static const String appWebsite = "https://cloudcardanofaucet.blogspot.com/";
  static const String allAppsWebsite = "https://cryptofaucetapps.com/";
  static const String appVersionFromRemote =
      "${coingekoNetworkName}_app_version";
  static const String latestAppFromRemote = "latest_app";
  static const String appLogoForDynamicLink =
      "https://firebasestorage.googleapis.com/v0/b/dogecoin-faucet-ce9c1.appspot.com/o/Applogos%2Fcloud_cardano_faucet.png?alt=media&token=02eff1e7-8820-48b2-8dcb-5b7fc40c69b5";

  ////////////////////////// New Constants //////////////////////

  ///App Detail
  static const String appCoinName = "Cardano_Faucet";
  static const int appNumber = 1;
  static const String referral = "Referral";

  ///Firestore Collections / Sub Collections / Doc Ids

  //Collections One

  //Collections Two
  static const String collUsers = "Users";
  static const String collWeeklyEvent = "Weekly_Event";
  static const String collWeeklyGiveAwayWinners = "Weekly_GiveAway_Winners";
  static const String collGroupChat = "Group_Chat";
  static const String collChats = "Chats";
  static const String collAnnouncements = "Announcements";
  static const String collWithdrawRequests = "Withdraw_Requests";
  static const String collPaymentProofs = "Payment_Proofs";
  static const String collFaucetPayProofs = "FaucetPayReview_Proofs";
  static const String collSubscribers = "Subscribers";
  static const String collIssues = "Issues";
  static const String collIssuesChats = "Chats";
  static const String collBlockedUsers = "Blocked_Users";

  //Collections Three
  static const String subCollReferral = "Referral";
  static const String subCollNotifications = "Notifications";
  static const String subCollTransactions = "Transactions";

  //Document
  static const String docAppNumber = "${appCoinName}_$appNumber";

  ///////////////////////////////////////////////////////////////////////////

  static const String faucetPayReviewLink =
      "https://faucetpay.io/page/faucet/33212";

  //for dynamic link
  static const String errorMessage =
      "Encountered Error, may be due to heavy traffic of users or may be you have 0 claims left for today or using old version app. Please Try Again Later";

  //Intervals for next Claims
  static const int claimTimer = 20;
  static const int hourlyBonusTimer = 60;

  //rewards per claim for basic users
  static const int claimReward = 50;
  static const int giveAwayReward = 10000;
  static const int youtubeSubReward = 500;
  static const int screenshotShareReward = 5000;
  static const double decimal = 0.000001;
  static const double minimumWithdrawalLimit = 0.00001;
  static const int decimalLength = 6;
  static const int multiplyNum = 1000000;

  static const double miscellaneousReward = 1000;

  //Daily Clicks Available
  static const int dailyClicksAvailable = 50;

  //Intervals for next Claims
  static const int spinClaimTimer = 20;
  static const int ngClaimTimer = 20;
  static const int dailyBonusPoints = 30;

  //rewards per claim for basic users
  static const int totalSpins = 50;
  static const int totalScratch = 50;
  static const int totalNumberGame = 50;

  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.transparent),
  );

  //Config Main Colors

  static const Color darkBG = Color(0xff1F2533);
  static const Color dashboardContainerCoplor = Color(0xff1E1E1E);

  static const List<Color> darkBGColors = [darkBG, darkBG];

  static const List<Color> lightBGColors = [
    Color(0xff0D5F64),
    Color(0xff219077),
    Color(0xffA5CDCC)
  ];

  /*This is the Text for onboarding screen*/
  static const titleOne = "Welcome ! Nice to meet You";
  static const titleTwo = "Quick Support !";
  static const titleThree = "Collect Daily Coins !";
  static const titleFour = "Wallets";
  static const bodyOne =
      "I`m so glad you decided to try out ${Constants.appName} App ";
  static const bodyTwo =
      "We have a dedicated tech support team to resolve your issues instantly";
  static const bodyThree =
      "You are on the correct app to collect ${Constants.coinName}, This is the easiest way ever existed";
  static const bodyFour = "You can transfer your funds anytime to your wallets";

//Image

  static const String appLogo = "assets/images/app_logo.png";
  static const String coinImage = "assets/images/coins.png";
  static const String newImage = "assets/images/newimage.png";
  static const String outerImage = "assets/images/outerimage.png";
  static const String refIcon = "assets/images/refer_icon.png";
  static const String weeklyIcon = "assets/images/weekly_icon.png";

  static const String noInternet = "assets/connectivity.json";
  static const String bonusLoading = "assets/bonusloading.json";
  static const String lottieOne = "assets/lottie/lottie_one.json";
  static const String lottieTwo = "assets/lottie/lottie_two.json";
  static const String lottieThree = "assets/lottie/lottie_three.json";
  static const String lottieFour = "assets/lottie/lottie_four.json";
  static const String lottieFive = "assets/lottie/lottie_five.json";
  static const String scratch = "assets/lottie/scratch.json";
  static const String scratchTwo = "assets/lottie/scratch_two.json";
  static const String wheel = "assets/lottie/wheels.json";
  static const String number = "assets/lottie/number.json";
  static const String bonus = "assets/lottie/wheels.json";

  //*  Texts
  static const appLink =
      'https://play.google.com/store/apps/details?id=${Constants.packageName}';
  static const String descAboutApp =
      '''${Constants.appName} is a fun app for earning ${Constants.coinName} .We have developed this application to let the users earn cryptocurrency in a fun way. We are planning to add more fun games and events to earn more cryptocurrencies''';

  static const String contactUs = "Contact Us";

  static const String withdrawNote =
      "Note- Check the coinbase email properly before withdrawing your funds, if found using wrong coinbase email address, payment will be cancelled and will not be refunded";
  static const String approvalTime =
      "You Will receive your payment within 72 hours";

  static const String activityNotes =
      "Note- Trying to attempt any sort of fraudulent activity like using vpn, using multiple account will lead to account banned";

  //policies
  static const String termsCondition =
      "By downloading or using the app, these terms will automatically apply to you ??? you should make sure therefore"
      " that you read them carefully before using the app. You???re not allowed to copy, or modify the app, any part of the app, or our trademarks "
      "in any way. You???re not allowed to attempt to extract the source code of the app, and you also shouldn???t try to translate the app into other "
      "languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property "
      "rights related to it, still belong to The Developer of the App. The Developer of the App is committed to ensuring that the app is as useful and efficient as "
      "possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. "
      "We will never charge you for the app or its services without making it very clear to you exactly what you???re paying for. The ${Constants.appName}"
      " stores and processes personal data that you have provided to us,"
      " in order to provide my Service. It???s your responsibility to keep your phone and access to the app secure."
      " We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and "
      "limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious "
      "programs, compromise your phone???s security features and it could mean that the ${Constants.appName} won???t work properly or at all. The"
      " app does use third party services that declare their own Terms and Conditions. Link to Terms and Conditions of third party service "
      "providers used by the app \n  1. Google Play Services \n  2. Google Analytics for Firebase \n  3. Firebase Crashlytics "
      "\n  4. Facebook You should be aware that there are certain things that The Developer of the App will not take responsibility for."
      " Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, "
      "or provided by your mobile network provider, but The Developer of the App cannot take responsibility for the app not working at full functionality if "
      "you don???t have access to Wi-Fi, and you don???t have any of your data allowance left. If you???re using the app outside of an area with Wi-Fi, you"
      " should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your "
      "mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app,"
      " you???re accepting responsibility for any such charges, including roaming data charges if you use the app outside of"
      " your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you???re "
      "using the app, please be aware that we assume that you have received permission from the bill payer for using the app. Along the same lines,"
      " The Developer of the App cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged ??? "
      "if it runs out of battery and you can???t turn it on to avail the Service, The Developer of the App cannot accept responsibility. With respect to ${Constants.appOwnerName} "
      " responsibility for your use of the app, when you???re using the app, it???s important to bear in mind that although we endeavour to ensure "
      "that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. "
      "The Developer of the App accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of"
      " the app. At some point, we may wish to update the app. The app is currently available on Android ??? the requirements for system(and for any additional systems we decide to extend the availability of the app to) may change, and you???ll need to download the updates if you want to keep using the app. ${Constants.appOwnerName}  does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use "
      "of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted "
      "to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device";

  static const String privacy =
      "The Developer of the App built the ${Constants.appName} as a fun app for Earning ${Constants.coinName}. This SERVICE is provided by ${Constants.appOwnerName}  and his team and "
      "is intended for use as is. This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal"
      " Information if anyone decided to use my Service. If you choose to use my Service, then you agree to the collection and use of information "
      "in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share"
      " your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in "
      "our Terms and Conditions, which is accessible at ${Constants.appName} unless otherwise defined in this Privacy Policy.";
  static const String informationCollection =
      "For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information"
      " that I request will be retained on your device and is not collected by me in any way.The app does use third party services that may collect"
      " information used to identify you.Link to privacy policy of third party service providers used by the ap\n 1. Google Play Service"
      "\n 2. Google Analytics for Firebase \n 3.  Firebase Crashlytics \n 4. Facebook";
  static const String logData =
      "I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (???IP???) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.";
  static const String cookies =
      "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these ???cookies??? explicitly. However, the app may use third party code and libraries that use ???cookies??? to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.";
  static const String servicesProvider =
      "I may employ third-party companies and individuals due to the following reasons: \n   1. To facilitate our Service; \n   2. To provide the Service on our behalf; \n   3. To perform Service-related services; or \n   4.  To assist us in analyzing how our Service is used. \n I want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.";
  static const String security =
      "I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.";
  static const String linksToOhters =
      "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.";
  static const String changesToPolicies =
      "I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of 2020-05-03";
  static const String contactUsTextForPolicy =
      "If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at ${Constants.email}";
}
