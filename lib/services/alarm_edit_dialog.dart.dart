import 'package:flutter/material.dart';
import '../models/alarm_model.dart';
import '../services/alarm_service.dart';

class AlarmEditDialog extends StatefulWidget {
  final Alarm? alarm;
  final int nextId;
  final Function(Alarm, bool) onSave;

  const AlarmEditDialog({
    Key? key,
    this.alarm,
    required this.nextId,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AlarmEditDialog> createState() => _AlarmEditDialogState();
}

class _AlarmEditDialogState extends State<AlarmEditDialog> {
  late TextEditingController titleController;
  late TextEditingController timeController;
  late RecurrenceType selectedRecurrence;
  late List<int> selectedDays;
  int? intervalHours;
  bool startFromNow = false;

  @override
  void initState() {
    super.initState();
    print("object");
    titleController = TextEditingController(text: widget.alarm?.title ?? '');
    timeController = TextEditingController(
      // text: widget.alarm?.time.format() ?? ""
    );
    selectedRecurrence = widget.alarm?.recurrenceType ?? RecurrenceType.once;
    selectedDays = List.from(widget.alarm?.selectedDays ?? []);
    intervalHours = widget.alarm?.intervalHours;
    startFromNow = widget.alarm?.startFromNow ?? false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // إذا كان الحقل فارغاً (أي منبه جديد)، نضع الوقت الحالي بتنسيق الـ context الصحيح
    if (timeController.text.isEmpty) {
      setState(() {
        timeController.text = TimeOfDay.now().format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.alarm != null;

    return AlertDialog(
      
      title: Text(isEditing ? 'تعديل المنبه' : 'إضافة منبه جديد'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitleField(),
            const SizedBox(height: 16),
            _buildTimePicker(context),
            const SizedBox(height: 16),
            _buildRecurrenceDropdown(),
            const SizedBox(height: 16),
            if (selectedRecurrence == RecurrenceType.custom) _buildDaysPicker(),
            if (selectedRecurrence == RecurrenceType.interval)
              _buildIntervalSection(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD2691E),
          ),
          child: Text(isEditing ? 'تحديث' : 'إضافة'),
        ),
      ],
    );
  }

  // --- الدوال الفرعية لبناء الـ UI (نفس منطق كودك الأصلي) ---

  Widget _buildTitleField() {
    return TextField(
      controller: titleController,
      decoration: InputDecoration(
        labelText: 'عنوان المنبه',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(), // تبسيط للمنطق
        );
        if (picked != null) {
          setState(() {
            timeController.text =
                '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الوقت: ${timeController.text}'),
            const Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }

  Widget _buildRecurrenceDropdown() {
    return DropdownButton<RecurrenceType>(
      value: selectedRecurrence,
      isExpanded: true,
      items: RecurrenceType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(_recurrenceTypeText(type)),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedRecurrence = value ?? RecurrenceType.once;
          if (selectedRecurrence != RecurrenceType.interval)
            intervalHours = null;
        });
      },
    );
  }

  Widget _buildDaysPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر الأيام:'),
        Wrap(
          spacing: 8,
          children: [
            _dayChip('الاثنين', 0),
            _dayChip('الثلاثاء', 1),
            _dayChip('الأربعاء', 2),
            _dayChip('الخميس', 3),
            _dayChip('الجمعة', 4),
            _dayChip('السبت', 5),
            _dayChip('الأحد', 6),
          ],
        ),
      ],
    );
  }

  Widget _buildIntervalSection() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('ابدأ من الآن'),
          value: startFromNow,
          onChanged: (v) => setState(() => startFromNow = v),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'كل كم ساعة؟',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onChanged: (value) => intervalHours = int.tryParse(value),
        ),
      ],
    );
  }

  Widget _dayChip(String label, int dayIndex) {
    final isSelected = selectedDays.contains(dayIndex);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selected ? selectedDays.add(dayIndex) : selectedDays.remove(dayIndex);
        });
      },
      selectedColor: const Color(0xFFD2691E),
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }

  void _handleSave() async {
    if (titleController.text.isEmpty) return;

    final parts = timeController.text.split(':');
    final newAlarm = Alarm(
      id: widget.alarm?.id ?? widget.nextId.toString(),
      title: titleController.text,
      time: TimeOfDayModel(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1].split(' ')[0]),
      ),
      recurrenceType: selectedRecurrence,
      selectedDays: selectedDays,
      intervalHours: intervalHours,
      startFromNow: startFromNow,
    );

    // تنفيذ الحفظ والجدولة عبر الـ Callback
    AlarmService().scheduleAlarm(newAlarm);
    widget.onSave(newAlarm, widget.alarm != null);
    Navigator.pop(context);
  }

  String _recurrenceTypeText(RecurrenceType type) {
    switch (type) {
      case RecurrenceType.once:
        return 'مرة واحدة';
      case RecurrenceType.daily:
        return 'يومياً';
      case RecurrenceType.custom:
        return 'أيام محددة';
      case RecurrenceType.interval:
        return 'كل X ساعة';
    }
  }
}
