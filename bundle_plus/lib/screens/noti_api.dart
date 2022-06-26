import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiApi {
  static final _noti = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
      ),
    );
  }

  static Future showNoti({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _noti.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
