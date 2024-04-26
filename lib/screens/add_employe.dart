import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddEmployeeScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('employees');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text.trim();
                String position = _positionController.text.trim();
                if (name.isNotEmpty && position.isNotEmpty) {
                  _addEmployee(name, position);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _addEmployee(String name, String position) {
    _database.child(name).set({
      'position': position,
    });
  }
}