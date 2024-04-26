import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'add_employe.dart';

class HomeScreen extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance as DatabaseReference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: StreamBuilder(
        stream: _database.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic>? employees = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?; // Casting tipe
            return ListView.builder(
              itemCount: employees!.length,
              itemBuilder: (context, index) {
                String name = employees.keys.elementAt(index);
                String position = employees[name]['position'];
                return ListTile(
                  title: Text(name),
                  subtitle: Text(position),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
