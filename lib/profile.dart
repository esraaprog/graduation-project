import 'package:alarm/reports.dart';
import 'package:flutter/material.dart';

class PatientProfil extends StatefulWidget {
  const PatientProfil({super.key});

  @override
  State<PatientProfil> createState() => _PatientProfilState();
}

class _PatientProfilState extends State<PatientProfil> {
  Widget _buildWeeklyMedicineTracker(String medName, String dosage) {
    List<String> days = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun",
    ];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رأس الكرت: اسم الدواء
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  medName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                Text(
                  dosage,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 5),

            // الجدول الأسبوعي
            SingleChildScrollView(
              scrollDirection:
                  Axis.horizontal, // للتمرير العرضي إذا كانت الشاشة صغيرة
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(
                  60,
                ), // عرض ثابت لكل يوم
                border: TableBorder.all(
                  color: Colors.grey.shade200,
                  width: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                children: [
                  // صف أسماء الأيام
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.05),
                    ),
                    children:
                        days
                            .map(
                              (day) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    day,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  // صف مربعات الاختيار (التي سيملأها المريض)
                  TableRow(
                    children:
                        days
                            .map(
                              (day) => Center(
                                child: Checkbox(
                                  value:
                                      false, // هنا تربطها بالداتا لاحقاً (مثلاً: checkStatus[day])
                                  activeColor: Colors.green,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      // تحديث الحالة هنا
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Check the boxes for the days you took the medication",
              style: TextStyle(
                fontSize: 10,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Name'),
        // centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        // للسماح بالتمرير إذا كانت البيانات كثيرة
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              children: [
                _buildInfoCard(
                  "Age",
                  "25 Years",
                  Icons.calendar_today,
                  Colors.deepOrange,
                ),
                _buildInfoCard(
                  "Weight",
                  "70 Kg",
                  Icons.line_weight,
                  Colors.deepOrange,
                ),
                _buildInfoCard(
                  "Height",
                  "170 cm",
                  Icons.height,
                  Colors.deepOrange,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row( 
                  children: [
                    Icon(Icons.warning, color: Colors.deepOrange, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Allergies",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: const Color(0xFFFFFFFF),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),

                      child: Column(
                        children: [
                          // const SizedBox(height: 10),
                          Text(
                            "No known allergies lorem dsmvlsmv snvlsnnv sdnvsvisivo sdnvisnvisv sdnvisvosmv sdnvdsdnvosvps sdvpismvpsmvs",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // قسم مواعيد الوجبات
            _buildSectionTitle("Meal Times", Icons.restaurant),
            _buildDataCard([
              _buildListTile("Breakfast", "08:00 AM", Icons.wb_sunny_outlined),
              _buildListTile("Lunch", "02:00 PM", Icons.wb_cloudy_outlined),
              _buildListTile("Dinner", "08:00 PM", Icons.nightlight_round),
            ]),

            const SizedBox(height: 20),

            // قسم جدول الأدوية
            // قسم جدول الأدوية (نسخة الجدول النظامي)
            // _buildSectionTitle("جدول الأدوية الأسبوعي", Icons.medication),
            // _buildDataCard([
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: SizedBox(
            //       width: double.infinity, // لضمان أخذ كامل عرض الشاشة
            //       child: DataTable(
            //         columnSpacing: 20,
            //         headingRowColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.1)),
            //         columns: const [
            //           DataColumn(label: Text('الدواء', style: TextStyle(fontWeight: FontWeight.bold))),
            //           DataColumn(label: Text('الجرعة', style: TextStyle(fontWeight: FontWeight.bold))),
            //           DataColumn(label: Text('الموعد', style: TextStyle(fontWeight: FontWeight.bold))),
            //         ],
            //         rows: [
            //           _buildMedicineRow("باندول", "500mg", "بعد الغداء"),
            //           _buildMedicineRow("فيتامين C", "1000mg", "صباحاً"),
            //           _buildMedicineRow("أوميبرازول", "20mg", "قبل الإفطار"),
            //         ],
            //       ),
            //     ),
            //   ),
            // ]),
            // قسم متابعة الأدوية
            // _buildSectionTitle("Medication follow-up", Icons.checklist_rtl),
            // _buildMedicineTrackerCard("باندول - Panadol", "500mg", ["فطور", "غداء", "عشاء"]),
            // _buildMedicineTrackerCard("أوميبرازول", "20mg", ["قبل الإفطار"]),
            // _buildMedicineTrackerCard("فيتامين C", "1000mg", ["بعد الغداء"]),
            _buildWeeklyMedicineTracker(
              "  Panadol",
              "500mg - One tablet after lunch",
            ),

            const SizedBox(height: 10), // مسافة بين الكروت

            _buildWeeklyMedicineTracker("Omeprazole", "20mg - Before breakfast"),

            const SizedBox(height: 10),

            _buildWeeklyMedicineTracker("Vitamin C", "1000mg - After lunch"),

            const SizedBox(height: 20),

            // قسم التقارير الطبية
            _buildSectionTitle("Medical Reports", Icons.assignment),
            _buildDataCard([
              _buildListTile(
                "Reports",
                "view report",
                Icons.report,
                onTap: () {
                  //  Navigator.push(context, MaterialPageRoute(builder:  (context) =>  Reports()));
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // ويلدجت لبناء كروت المعلومات الصغيرة (العمر والوزن)
  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويلدجت لعنوان القسم
  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // حاوية للبيانات (قائمة داخل كارد)
  Widget _buildDataCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(children: children),
    );
  }

  // سطر بيانات فردي
  Widget _buildListTile(
    String title,
    String subtitle,
    IconData leadingIcon, {
    IconData? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(leadingIcon, color: Colors.deepOrangeAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing:
          trailing != null
              ? Icon(trailing, size: 20, color: Colors.grey)
              : null,
      onTap: onTap,
    );
  }
}

// دالة بناء كرت الدواء مع مربعات المتابعة
// دالة بناء جدول المتابعة الأسبوعي لكل دواء
// دالة بناء جدول المتابعة الأسبوعي لكل دواء
