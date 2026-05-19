import 'package:flutter/material.dart';

class NurseDashboardScreen extends StatelessWidget {
  const NurseDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c1 = const Color(0xFFD2691E); // تم إضافة const لتحسين الأداء

    return DefaultTabController(
      length: 3, // عدد الأقسام
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: c1,
          title: const Text('Nurse'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.warning), text: "Critical cases"),
              Tab(icon: Icon(Icons.history), text: "History"),
            ],
          ), // تم تعديل النص ليكون أرتب
        ),
        body: TabBarView(
          children: [_buildCriticalCaseslist(), _buildAllPatientsList()],
        ),
        // body:
      ),
    );
  }

  Widget _buildCriticalCaseslist() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.person, color: Color(0xFFD2691E)),
            title: Text('Patient ${index + 1}'),
            subtitle: Text('Stable condition - Last check ${index + 5} minutes ago'),
            trailing: ElevatedButton(
              onPressed: () {
                _showDecisionBottomSheet(context);
              },
              child: Text("procedure"),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAllPatientsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.person, color: Color(0xFFD2691E)),
            title: Text('Patient ${index + 1}'),
            subtitle: Text('Stable condition - Last check ${index + 5} minutes ago'),
          ),
        );
      },
    );
  }

  void _showDecisionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Taking Measures',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exposure_plus_2, color: Colors.orange),
              title: Text('Call doctor'),
              onTap: () {
                /* كود التعديل التلقائي */
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: Colors.red),
              title: Text('Ignor' ),
              onTap: () {
                /* كود إعادة الجدولة */
              },
            ),
          ],
        ),
      ),
    );
  }
}
