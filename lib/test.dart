import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnimalUploadEditPage extends StatefulWidget {
  @override
  _AnimalUploadEditPageState createState() => _AnimalUploadEditPageState();
}

class _AnimalUploadEditPageState extends State<AnimalUploadEditPage> {
  DateTime selectedDate = DateTime.now();
  String? selectedCategory;
  String? selectedSex;
  String? selectedStatus;
  String? selectedType;
  XFile? imageFile;
  TextEditingController dateCtl = TextEditingController();

  final _categories = ['Category 1', 'Category 2']; // Example categories
  final _sexes = ['Male', 'Female'];
  final _statuses = ['Status 1', 'Status 2']; // Example statuses
  final _types = ['Type 1', 'Type 2']; // Example types

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateCtl.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Upload/Edit'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // ... Rest of your code ...

            // Date of birth
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: dateCtl,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    hintText: "Add Date of Birth",
                  ),
                ),
              ),
            ),

            // ... Rest of your code ...

            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add/Save animal logic
                },
                child: Text('Add Animal'),
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              ),
            ),
            // Add more form fields if necessary
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    dateCtl.dispose();
    super.dispose();
  }
}
