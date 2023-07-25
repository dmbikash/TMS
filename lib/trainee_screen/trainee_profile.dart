import 'package:flutter/material.dart';

class TraineeProfile extends StatefulWidget {
  const TraineeProfile({Key? key}) : super(key: key);

  @override
  _TraineeProfileState createState() => _TraineeProfileState();
}

class _TraineeProfileState extends State<TraineeProfile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text("JHAKA NAKA\nPROFILE")),
    )
    ;
  }
}
