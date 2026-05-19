import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/alarm_model.dart';

class AlarmStorageService {
  static const String _key = 'alarms';

  static Future<void> saveAlarms(List<Alarm> alarms) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = alarms.map((alarm) => _alarmToJson(alarm)).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  static Future<List<Alarm>> loadAlarms() async {//تحميل المنبهات الموجودة من قبل
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => _alarmFromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> deleteAlarm(String id) async {
    final alarms = await loadAlarms();
    alarms.removeWhere((alarm) => alarm.id == id);
    await saveAlarms(alarms);
  }

  static Map<String, dynamic> _alarmToJson(Alarm alarm) {
    return {
      'id': alarm.id,
      'title': alarm.title,
      'time': alarm.time.format(),
      'recurrenceType': alarm.recurrenceType.toString(),
      'selectedDays': alarm.selectedDays,
      'intervalHours': alarm.intervalHours,
      'startFromNow': alarm.startFromNow,
    };
  }

  static Alarm _alarmFromJson(dynamic json) {
    return Alarm(
      id: json['id'] as String,
      title: json['title'] as String,
      time: TimeOfDayModel.fromString(json['time'] as String),
      recurrenceType: _parseRecurrenceType(json['recurrenceType'] as String),
      selectedDays: List<int>.from(json['selectedDays'] as List? ?? []),
      intervalHours: json['intervalHours'] as int?,
      startFromNow: json['startFromNow'] as bool? ?? false,
    );
  }

  static RecurrenceType _parseRecurrenceType(String type) {
    switch (type) {
      case 'RecurrenceType.once':
        return RecurrenceType.once;
      case 'RecurrenceType.daily':
        return RecurrenceType.daily;
      case 'RecurrenceType.custom':
        return RecurrenceType.custom;
      case 'RecurrenceType.interval':
        return RecurrenceType.interval;
      default:
        return RecurrenceType.once;
    }
  }
}
