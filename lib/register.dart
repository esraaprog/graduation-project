import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedRole = 'Patient';
  double _age = 50.0;
  double weight = 60;
  String _selectedBlood = 'A+';
  TimeOfDay selectedMealTime = TimeOfDay(hour: 8, minute: 0);
  String? fileName;
  Future<void> _pickMealTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedMealTime,
    );
    if (picked != null && picked != selectedMealTime) {
      setState(() {
        selectedMealTime = picked;
      });
    }
  }

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });

      print(result.files.single.path); // مسار الملف
    } else {
      print("لم يتم اختيار ملف");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.menu),
        // title: Text('Login Screen'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Sign In',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrange[400],
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              crossAxisAlignment:
                  WrapCrossAlignment.center, 
              
              spacing: 20, 
              runSpacing: 10,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Select your role?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange[400],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                DropdownButton<String>(
                  dropdownColor: Colors.deepOrange[100],
                  focusColor: Colors.white,
                  iconEnabledColor: Colors.deepOrange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                  value: _selectedRole,
                  items:
                      <String>['Patient', 'Doctor', 'Supervisor'].map((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        );
                      }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRole = newValue!;
                    });
                  },
                ),
              ],
            ),
            //SizedBox(height: 20),
            if (_selectedRole == 'Doctor')
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Specialization',
                        prefixIcon: Icon(Icons.medical_services),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Text(
                          'Upload your medical license:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange[400],
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: pickPDF,
                          child: Text("Upload PDF"),
                        ),
                      ],
                    ),
                  ),
                  if (fileName != null) Text(" Selected: $fileName"),
                ],
              ),
            ////////////////////////////////////////patient/////////////////////////////////////
            if (_selectedRole == 'Patient')
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///////////////////////////////////age
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select your age:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange[400],
                            ),
                          ),
                          Text(
                            ' ${_age.toInt()} years',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Slider(
                              value: _age,
                              min: 0,
                              max: 120,
                              divisions: 120,
                              thumbColor: Colors.deepOrangeAccent,
                              activeColor: Colors.deepOrangeAccent,
                              onChanged: (double value) {
                                setState(() {
                                  _age = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    //////////////////////////////////////weight
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange[400],
                            ),
                          ),
                          Text(
                            "${weight}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    /////////////////////////////////////blod
                    Container(
                      height: 290,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select your blood type:",

                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrange[400],
                                  fontSize: 20,
                                ),
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 5,
                                children: [
                                  ...[
                                    'A+',
                                    'A-',
                                    'B+',
                                    'B-',
                                    'O+',
                                    'O-',
                                    'AB+',
                                    'AB-',
                                  ].map((option) {
                                    return SizedBox(
                                      width: 160,
                                      child: RadioListTile<String>(
                                        //activeColor: Colors.deepOrange,
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((states) {
                                              if (states.contains(
                                                MaterialState.selected,
                                              )) {
                                                return Colors
                                                    .deepOrange; // عند التحديد
                                              }
                                              return Colors
                                                  .white; // عند عدم التحديد
                                            }),
                                        title: Text(
                                          option,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.deepOrange[400],
                                          ),
                                        ),
                                        value: option,
                                        groupValue: _selectedBlood,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedBlood = value!;
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),

                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     print(_selectedAnswer);
                                  //   },
                                  //   child: Text("Submit"),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///
                    SizedBox(height: 20),
                    ///////////////////////////////////alergies
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Have any allergies?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange[400],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: "Allergies",
                            labelStyle: TextStyle(
                              color: Colors.deepOrange[400],
                            ),
                            hintText: "Write your allergies here...",
                            hintStyle: TextStyle(color: Colors.deepOrange[100]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.deepOrange[100]!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///
                    //////////////////////////////////emmergency contact
                    SizedBox(height: 20),
                    Container(
                      // height: 130,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //SizedBox(height: 20),
                            Text(
                              "Input your emmergency contact number:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepOrange[400],
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'emmergency contact number',
                                labelStyle: TextStyle(
                                  color: Colors.deepOrange[400],
                                ),
                                prefixIcon: Icon(
                                  Icons.contact_emergency,
                                  color: Colors.deepOrange[400],
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange[400]!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    ///
                    //////////////////////////////////
                    Container(
                      // height: 220, // قللت الارتفاع ليكون أنسب
                       width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select your food time:",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.deepOrange[400],
                                //  fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 15),
                            Column(
                              children: [
                                Wrap(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () => _pickMealTime(context),
                                      icon: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Breakfast',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                     SizedBox(width: 20),
                                    Text(
                                      'Time: ${selectedMealTime.format(context)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),

                                Wrap(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () => _pickMealTime(context),
                                      icon: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Lunch',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Time: ${selectedMealTime.format(context)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Wrap(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () => _pickMealTime(context),
                                      icon: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Dinner',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Time: ${selectedMealTime.format(context)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///
                    ///
                    ///
                    SizedBox(height: 20),

                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepOrange[500],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
