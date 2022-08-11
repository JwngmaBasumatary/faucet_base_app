import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools {
  static Color hetToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static List<Color> multiColors = [
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.green
  ];

  static Widget titleAndDetails(
      String title, String details, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          details,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
        ),
      ],
    );
  }

  static int generateBasicRandomReward() {
    var rand = Random();
    return 7 + rand.nextInt(2);
  }

  static int generateSilverRandomReward() {
    var rand = Random();
    return 7 + rand.nextInt(3);
  }

  static int generateGoldRandomReward() {
    var rand = Random();
    return 7 + rand.nextInt(4);
  }

  static int generateDiamondRandomReward() {
    var rand = Random();
    return 7 + rand.nextInt(5);
  }

  static showToasts(String message) {
    BotToast.showText(
      text: message,
      duration: const Duration(seconds: 2),
    );
  }

  static launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Tools.showDebugPrint("Not A valid  Url");
      throw 'Could not launch $url';
    }
  }

  static showDebugPrint(String message) {
    debugPrint("Console : $message");
  }
}
