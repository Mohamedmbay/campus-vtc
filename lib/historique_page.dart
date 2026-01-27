import 'package:flutter/material.dart';

class HistoriquePage extends StatelessWidget {
  final List<String> courses;

  HistoriquePage({required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historique des courses"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.local_taxi),
            title: Text(courses[index]),
          );
        },
      ),
    );
  }
}
