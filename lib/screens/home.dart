import 'package:flutter/material.dart';
import 'package:alarm/services/alarm_edit_dialog.dart.dart';
import '../models/alarm_model.dart';
import '../services/alarm_service.dart';
import '../services/alarm_storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Alarm> _alarms = [];
  int _nextId = 1;

  // المتحكمات الخاصة بالمنبه الذكي
  final TextEditingController _smartTitleController = TextEditingController();
  final TextEditingController _smartHourController = TextEditingController();
  List<int> _smartSelectedDays = [];

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  // 1. تحميل المنبهات من التخزين
  Future<void> _loadAlarms() async {
    final loadedAlarms = await AlarmStorageService.loadAlarms();
    setState(() {
      _alarms = loadedAlarms;
      if (_alarms.isNotEmpty) {
        // تحديد الـ ID التالي بناءً على أكبر ID موجود
        _nextId = _alarms
                .map((e) => int.tryParse(e.id) ?? 0)
                .reduce((a, b) => a > b ? a : b) + 1;
      }
    });
  }

  // 2. حذف منبه
  Future<void> _deleteAlarm(String id) async {
    setState(() {
      _alarms.removeWhere((alarm) => alarm.id == id);
    });
    AlarmService().cancelAlarm(id);
    await AlarmStorageService.saveAlarms(_alarms);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف المنبه'), backgroundColor: Colors.orange),
    );
  }

  // 3. فتح نافذة التعديل/الإضافة اليدوية
  void _openAlarmDialog({Alarm? alarm}) async {
    await showDialog(
      context: context,
      builder: (context) => AlarmEditDialog(
        alarm: alarm,
        nextId: _nextId,
        onSave: (newAlarm, isEditing) async {
          setState(() {
            if (isEditing) {
              final index = _alarms.indexWhere((a) => a.id == alarm!.id);
              _alarms[index] = newAlarm;
            } else {
              _alarms.add(newAlarm);
              _nextId++;
            }
          });
          await AlarmStorageService.saveAlarms(_alarms);
          AlarmService().scheduleAlarm(newAlarm);
        },
      ),
    );
  }

  // 4. إضافة المنبه الذكي
  void _addSmartIntervalAlarm(int hours, String title, List<int> days) async {
    final now = TimeOfDay.now();
    final newAlarm = Alarm(
      id: _nextId.toString(),
      title: title,
      // تحويل الوقت الحالي لموديل الوقت الخاص بك
      time: TimeOfDayModel(hour: now.hour, minute: now.minute),
      recurrenceType: RecurrenceType.interval,
      intervalHours: hours,
      selectedDays: days,
      startFromNow: true,
    );

    setState(() {
      _alarms.add(newAlarm);
      _nextId++;
    });

    await AlarmStorageService.saveAlarms(_alarms);
    AlarmService().scheduleAlarm(newAlarm);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تفعيل المنبه الذكي'), backgroundColor: Colors.green),
    );
  }

  // 5. وصف المنبه (الذكاء في عرض الأيام)
  String _getAlarmDescription(Alarm alarm) {
    if (alarm.recurrenceType == RecurrenceType.custom) {
      if (alarm.selectedDays.length == 7) return 'يومياً (كل الأيام)';
      const daysNames = ['اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت', 'أحد'];
      return alarm.selectedDays.map((i) => daysNames[i]).join(', ');
    }
    switch (alarm.recurrenceType) {
      case RecurrenceType.once: return 'مرة واحدة';
      case RecurrenceType.daily: return 'يومياً';
      case RecurrenceType.interval: return 'كل ${alarm.intervalHours} ساعة';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('منبهات التخرج'),
          backgroundColor: const Color(0xFFD2691E),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.alarm), text: "المنبهات"),
              Tab(icon: Icon(Icons.auto_awesome), text: "منبه ذكي"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _alarms.isEmpty ? _buildEmptyState() : _buildAlarmList(),
            _buildSmartTab(),
          ],
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openAlarmDialog(),
          backgroundColor: const Color(0xFFD2691E),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // واجهة القائمة
  Widget _buildAlarmList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _alarms.length,
      itemBuilder: (context, index) {
        final alarm = _alarms[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.alarm, color: Color(0xFFD2691E)),
            title: Text(alarm.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('الوقت: ${alarm.time.format()}\n${_getAlarmDescription(alarm)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _openAlarmDialog(alarm: alarm),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteAlarm(alarm.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // واجهة المنبه الذكي
  Widget _buildSmartTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: _smartTitleController,
            decoration: const InputDecoration(labelText: "عنوان المنبه", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _smartHourController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "تكرار كل (عدد ساعات)", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 15),
          const Align(alignment: Alignment.centerRight, child: Text("أيام التكرار:")),
          Wrap(
            spacing: 8,
            children: List.generate(7, (index) {
              const days = ['ن', 'ث', 'ر', 'خ', 'ج', 'س', 'ح'];
              final isSelected = _smartSelectedDays.contains(index);
              return FilterChip(
                label: Text(days[index]),
                selected: isSelected,
                onSelected: (val) {
                  setState(() {
                    val ? _smartSelectedDays.add(index) : _smartSelectedDays.remove(index);
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD2691E), minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if (_smartHourController.text.isNotEmpty && _smartTitleController.text.isNotEmpty) {
                _addSmartIntervalAlarm(int.parse(_smartHourController.text), _smartTitleController.text, _smartSelectedDays);
                _smartHourController.clear();
                _smartTitleController.clear();
                setState(() => _smartSelectedDays = []);
                DefaultTabController.of(context).animateTo(0);
              }
            },
            child: const Text("تفعيل الآن"),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text("لا توجد منبهات حالياً"));
  }
}