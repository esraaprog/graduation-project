import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import '../models/alarm_model.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  factory AlarmService() {
    return _instance;
  }

  AlarmService._internal();

  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleAlarm(Alarm alarm) async {
    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      alarm.time.hour,
      alarm.time.minute,
    );

    switch (alarm.recurrenceType) {
      case RecurrenceType.once:
        await _scheduleOnce(alarm, alarmTime);
        break;
      case RecurrenceType.daily:
        await _scheduleDaily(alarm, alarmTime);
        break;
      case RecurrenceType.custom:
        await _scheduleCustomDays(alarm, alarmTime);
        break;
      case RecurrenceType.interval:
        await _scheduleInterval(alarm);
        break;
    }
  }

  Future<void> _scheduleOnce(Alarm alarm, DateTime alarmTime) async {
    // إذا كان الوقت قد مضى، جدولها لغداً
    if (alarmTime.isBefore(DateTime.now())) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(alarm.id),
      alarm.title,
      'منبه: ${alarm.time.format()}',
      tz.TZDateTime.from(alarmTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'المنبهات',
          channelDescription: 'قناة إشعارات المنبهات',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('alarm'),
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(sound: 'alarm.wav', presentSound: true),
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> _scheduleDaily(Alarm alarm, DateTime alarmTime) async {
    // جدولة يومياً في نفس الوقت
    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(alarm.id),
      alarm.title,
      'منبه: ${alarm.time.format()}',
      _nextInstanceOfTime(alarmTime.hour, alarmTime.minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'المنبهات',
          channelDescription: 'قناة إشعارات المنبهات',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('alarm'),
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(sound: 'alarm.wav', presentSound: true),
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _scheduleCustomDays(Alarm alarm, DateTime alarmTime) async {
    // جدولة لأيام محددة
    for (int dayIndex in alarm.selectedDays) {
      // حساب اليوم التالي من الأيام المحددة
      int daysUntil = (dayIndex - DateTime.now().weekday) % 7;
      if (daysUntil == 0 && DateTime.now().hour >= alarmTime.hour) {
        daysUntil = 7;
      }

      final scheduledDate = DateTime.now()
          .add(Duration(days: daysUntil))
          .copyWith(hour: alarmTime.hour, minute: alarmTime.minute);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse('${alarm.id}$dayIndex'),
        alarm.title,
        'منبه: ${alarm.time.format()}',
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_channel',
            'المنبهات',
            channelDescription: 'قناة إشعارات المنبهات',
            importance: Importance.max,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound('alarm'),
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            sound: 'alarm.wav',
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  Future<void> _scheduleInterval(Alarm alarm) async {
    if (alarm.intervalHours == null) return;

    final startTime = DateTime.now();
    final alarmTime = DateTime(
      startTime.year,
      startTime.month,
      startTime.day,
      alarm.time.hour,
      alarm.time.minute,
    );

    // جدولة أول منبه
    DateTime nextAlarmTime;
    if (alarm.startFromNow) {
      nextAlarmTime = DateTime.now().add(Duration(hours: alarm.intervalHours!));
    } else {
      nextAlarmTime = alarmTime.isBefore(startTime)
          ? startTime.add(Duration(hours: alarm.intervalHours!))
          : alarmTime;
    }

    // جدولة عدة منبهات متتالية (أسبوع واحد للبساطة)
    for (int i = 0; i < 168 ~/ alarm.intervalHours!; i++) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse('${alarm.id}$i'),
        alarm.title,
        'منبه: كل ${alarm.intervalHours} ساعة',
        tz.TZDateTime.from(nextAlarmTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_channel',
            'المنبهات',
            channelDescription: 'قناة إشعارات المنبهات',
            importance: Importance.max,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound('alarm'),
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            sound: 'alarm.wav',
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      nextAlarmTime = nextAlarmTime.add(Duration(hours: alarm.intervalHours!));
    }
  }

  Future<void> cancelAlarm(String alarmId) async {
    // إلغاء جميع المنبهات المرتبطة بهذا المعرف
    final id = int.parse(alarmId);
    await flutterLocalNotificationsPlugin.cancel(id);

    // إلغاء المنبهات المتكررة
    for (int i = 0; i < 200; i++) {
      try {
        await flutterLocalNotificationsPlugin.cancel(int.parse('$alarmId$i'));
      } catch (_) {}
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
