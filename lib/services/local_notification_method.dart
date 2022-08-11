import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../screens/local_noti_demo.dart';

class LocalNotificationMethod {
  static showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  static zonedScheduleNotification(
      {required seconds,
      required title,
      required body,
      payload,
      required channelId}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
        NotificationDetails(
          android: AndroidNotificationDetails(channelId, 'your channel name',
              channelDescription: 'your channel description',
              priority: Priority.high,
              importance: Importance.high),

          // android: AndroidNotificationDetails(
          //     'your channel id', 'your channel name',
          //     channelDescription: 'your channel description',
          //     priority: Priority.high,
          //     importance: Importance.high),
        ),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
