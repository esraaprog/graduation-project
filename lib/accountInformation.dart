import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final TextEditingController nameController = TextEditingController(text: "د. أحمد الرفاعي");
  final TextEditingController bioController = TextEditingController(text: "أخصائي جراحة عامة خبرة 10 سنوات");
  final TextEditingController clinicAddressController = TextEditingController(text: "دمشق - المزة - برج الأطباء");
  final TextEditingController phoneController = TextEditingController(text: "0933123456");

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    clinicAddressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // قسم الصورة في الأعلى مع زر التغيير
            _buildHeaderImage(),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("المعلومات العامة"),
                  const SizedBox(height: 15),
                  
                  // الحقول النصية للتعديل
                  _buildTextField(controller: nameController, label: "الاسم الكامل", icon: Icons.person),
                  _buildTextField(controller: bioController, label: "النبذة التعريفية", icon: Icons.description, maxLines: 3),
                  
                  const SizedBox(height: 20),
                  _buildSectionTitle("معلومات العيادة والتواصل"),
                  const SizedBox(height: 15),
                  
                  _buildTextField(controller: clinicAddressController, label: "عنوان العيادة", icon: Icons.location_on),
                  _buildTextField(controller: phoneController, label: "رقم الهاتف", icon: Icons.phone, keyboardType: TextInputType.phone),
                  
                  const SizedBox(height: 40),
                  
                  // زر حفظ التغييرات
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // هنا تضع كود حفظ البيانات في قاعدة البيانات
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("تم حفظ التعديلات بنجاح")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("حفظ التغييرات", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // الويجت التي كانت ناقصة وتسبب الخطأ المذكور
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),
    );
  }

  // ويجت لتصميم الحقل النصي
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepOrange),
          prefixIcon: Icon(icon, color: Colors.deepOrange),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
          ),
          filled: true,
          fillColor: Colors.deepOrange.withOpacity(0.05),
        ),
      ),
    );
  }

  // ويجت لتصميم رأس الصفحة (الصورة)
  Widget _buildHeaderImage() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      padding: const EdgeInsets.only(bottom: 30),
      child: Center(
        child: Stack(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 56,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), 
              ),
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 18,
                child: const Icon(Icons.camera_alt, color: Colors.black54, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}