import '../utils/tools.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class DynamicServices {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<String> createDynamicLinks({
    required bool short,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    String _linkToShare = "";

    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
        uriPrefix: Constants.firebaseDynamicUrl,
        link: Uri.parse("${Constants.appWebsite}/?uid=${user?.uid}"),
        androidParameters:
            const AndroidParameters(packageName: Constants.packageName),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: "The Best ${Constants.coinName} Paying Faucet App",
            description:
                "You can Earn unlimited ${Constants.coinName} using this App",
            imageUrl: Uri.parse(Constants.appLogoForDynamicLink)));

    Uri url;
    if (short == true) {
      final ShortDynamicLink shortDynamicLink =
          await dynamicLinks.buildShortLink(dynamicLinkParameters);
      url = shortDynamicLink.shortUrl;
      _linkToShare = url.toString();
      debugPrint("Short Link $_linkToShare");
    } else {
      url = await dynamicLinks.buildLink(dynamicLinkParameters);
      _linkToShare = url.toString();
      debugPrint("Long Link $_linkToShare");
    }

    return _linkToShare;
  }

  Future handleDynamicLinks(BuildContext context) async {
    debugPrint("Dynamic Link");
    // STARTUP FROM DYNAMIC LINK LOGIC
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      _handleDeepLink(context, deepLink);
    } else {
      Tools.showDebugPrint("Not Referred By Anyone");
    }
  }

  void _handleDeepLink(BuildContext context, Uri deepLink) async {
    debugPrint(" Handling The DeepLink");
    if (deepLink.path.isNotEmpty) {
      debugPrint("handle DeepLink In |  deepLink: $deepLink");
      var uid = deepLink.queryParameters['uid'];
      debugPrint("handle DeepLink |  Uid: $uid");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("refId", uid!);
    }
  }
}
