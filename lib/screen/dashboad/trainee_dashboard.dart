import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/trainer_dashboard_provider.dart';

import '../../components/box_decorations.dart';
import '../../components/color.dart';
import '../../components/my_app_bar.dart';
import '../../components/screen_size.dart';
import '../../components/text_style.dart';
import '../../provider/admin_dashboard_provider.dart';
import '../../provider/trainee_dashboard_provider.dart';



class TraineeDashboard extends StatefulWidget {
  const TraineeDashboard({Key? key}) : super(key: key);

  @override
  State<TraineeDashboard> createState() => _TraineeDashboardState();
}

class _TraineeDashboardState extends State<TraineeDashboard> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TraineeDashboardProvider>(
      builder: (context, traineeProvider, child) {
        return Scaffold(
          appBar: MyAppBar(
            title: 'TMS: trainee',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  width: width(context),
                  height: height(context) * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(                                //side menu
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 38, 5),
                          child: Container(
                            height: height(context) * 0.8,
                            decoration: box12Sidebar,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: TextLiquidFill(
                                        text: 'DashBoard',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: TextLiquidFill(
                                        text: 'Profile',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: TextLiquidFill(
                                        text: 'Logout',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //body
                      Expanded(                                // dashboard
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(100, 60, 0, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Classroom',
                                      subtitle: 'Your Classroom Information',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Group Chat',
                                      subtitle: 'Join the Group Chat',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Assignment',
                                      subtitle: 'View Your Assignments',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Courses',
                                      subtitle: 'Explore Available Courses',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Schedule',
                                      subtitle: 'View Your Schedule',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDashboardCard({required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 50, 40),
      child: SizedBox(
        width: 280, // Set a fixed width for the card
        height: 220, // Set a fixed height for the card
        child: Container(
          decoration: box12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                subtitle,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Navigate to corresponding page on button press
                },
                child: Text('Go to $title'),
              ),
            ],
          ),
        ),
      ),
    );
  }



}