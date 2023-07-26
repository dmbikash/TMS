import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/trainer_profile.dart';

class TrainerProfile extends StatefulWidget {
  const TrainerProfile({Key? key}) : super(key: key);

  @override
  State<TrainerProfile> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerProfile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrainerProfileProvider>(
      builder:(context, trainerProfileProvider, child){
      return  Container(
        child: FutureBuilder<dynamic>(
          future: trainerProfileProvider.getUserInfobyUserId(),
          builder: (context, snapshot){
            print(snapshot.data);
            if(!snapshot.hasData){
              return Text("golmal");
            }
            var userInfo = snapshot.data!;
            return Container(child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network("http://localhost:8090/trainer/profile-picture/"+userInfo["trainerId"].toString()),
                    Text(userInfo["fullName"]),
                    Text("Designation " + userInfo["designation"]),
                    Text("Joining Date " + userInfo["joiningDate"]),
                    Text("Years Of Experience " + userInfo["yearsOfExperience"]),
                    Text("Email " + userInfo["email"]),
                    Text("Contact Number " + userInfo["contactNumber"]),
                    Text("Present Address " + userInfo["presentAddress"]),
                  ],
                )));
          },
        ),
      );
      }
    )
    ;
  }

}
