import 'package:flutter/material.dart';

class TraineeDashboard extends StatefulWidget {
  const TraineeDashboard({Key? key}) : super(key: key);

  @override
  State<TraineeDashboard> createState() => _TraineeDashboardState();
}

class _TraineeDashboardState extends State<TraineeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainee"),
      ),
    );
  }
}
