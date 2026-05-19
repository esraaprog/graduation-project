class Alarm {
  final String id;
  final String title;
  final TimeOfDayModel time;
  final RecurrenceType recurrenceType;
  final List<int> selectedDays; // 0-6 for Monday-Sunday
  final int? intervalHours; // للمنبهات المتكررة كل X ساعة
  final bool startFromNow; // لمنبهات interval: ابداء من الآن بدل وقت محدد

  Alarm({
    required this.id,
    required this.title,
    required this.time,
    required this.recurrenceType,
    this.selectedDays = const [],
    this.intervalHours,
    this.startFromNow = false,
  });

  Alarm copyWith({
    String? id,
    String? title,
    TimeOfDayModel? time,
    RecurrenceType? recurrenceType,
    List<int>? selectedDays,
    int? intervalHours,
    bool? startFromNow,
  }) {
    return Alarm(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      selectedDays: selectedDays ?? this.selectedDays,
      intervalHours: intervalHours ?? this.intervalHours,
      startFromNow: startFromNow ?? this.startFromNow,
    );
  }
}

enum RecurrenceType {
  once, // مرة واحدة فقط
  daily, // يومياً
  custom, // أيام محددة
  interval, // كل X ساعة
}

class TimeOfDayModel {
  final int hour;
  final int minute;

  TimeOfDayModel({required this.hour, required this.minute});

  String format() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  factory TimeOfDayModel.fromString(String str) {
    final parts = str.split(':');
    return TimeOfDayModel(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  TimeOfDayModel copyWith({int? hour, int? minute}) {
    return TimeOfDayModel(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }
}
