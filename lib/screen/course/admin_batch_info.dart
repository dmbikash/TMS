import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:training_management_system/provider/admin_batch_info_provider.dart';
import 'package:http/http.dart' as http;
import '../../components/box_decorations.dart';
import '../../components/color.dart';
import '../../components/my_app_bar.dart';
import '../../components/screen_size.dart';
import '../../components/text_style.dart';
import "package:universal_html/html.dart" as html;


class AdminBatchInfo extends StatefulWidget {
  const AdminBatchInfo({Key? key}) : super(key: key);

  @override
  _AdminBatchInfoState createState() => _AdminBatchInfoState();
}

class _AdminBatchInfoState extends State<AdminBatchInfo> {

  final _courseFormKey = GlobalKey<FormState>();
  final _courseName = TextEditingController();
  final _description = TextEditingController();
  final _startDateCourseController = TextEditingController();
  final _endDateCourseController = TextEditingController();

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      // Format the selected date
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print('Selected date: $formattedDate');

      // Update the text controller with the selected date
      _startDateCourseController.text = formattedDate;
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      // Format the selected date
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print('Selected end date: $formattedDate');

      // Update the text controller with the selected date
      _endDateCourseController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminBatchInfoProvider>(
      builder: (context, adminBatchInfoProvider, child) {   //????
        return Scaffold(
          appBar: MyAppBar(
            title: 'TMS: Batch Info',
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
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 38.0),
                          child: Container(
                            height: height(context) * .80,
                            decoration: box12Sidebar,
                            //color: Colors.orangeAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //decoration: box12Sidebar,
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
                                  onTap: (){
                                    //Navigator.pop(context);
                                    Navigator.pushNamed(context, "AdminDashboard");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //decoration: box12Sidebar,
                                      child: TextLiquidFill(
                                        text: 'BATCH',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, "TraineeRegister");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: TextLiquidFill(
                                        text: 'CREATE ACCOUNT',
                                        waveColor: sweetYellow,
                                        boxBackgroundColor: Colors.black,
                                        textStyle: black20,
                                        boxHeight: 70,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){},
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
                                      title: 'Trainer Assign',
                                      subtitle: 'Assign Trainer in Batch',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Assign Trainee',
                                      subtitle: 'Assign Trainee in Batch',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      QuickAlert.show(
                                          onConfirmBtnTap: (){
                                            if(_courseFormKey.currentState!.validate()){
                                              postCourse({
                                                'courseName': _courseName.text,
                                                'description': _description.text,
                                                'startDate': _startDateCourseController.text,
                                                'endDate': _endDateCourseController.text,
                                              });
                                            }
                                          },
                                          context: context,
                                          type: QuickAlertType.info,
                                          confirmBtnColor: sweetYellow,
                                          confirmBtnText: "Create",
                                          title: "Create Course",
                                          //customAsset: FlutterLogo(),

                                          widget: Form(
                                            key: _courseFormKey,
                                            child: Column(
                                              children: [

                                                TextFormField(
                                                  validator: (val){
                                                    if(val!.isEmpty) return "value des nai oak thu";
                                                  },
                                                  controller: _courseName,
                                                  decoration: InputDecoration(hintText: "Course Name"),
                                                ),

                                                TextFormField(
                                                  validator: (val){
                                                    if(val!.isEmpty) return "value des nai oak thu";
                                                  },
                                                  controller: _description,
                                                  decoration: InputDecoration(hintText: "Description"),
                                                ),

                                                Container(
                                                  height: 100,
                                                  width: 500,
                                                  //color: Colors.red,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: TextFormField(
                                                          validator: (val){
                                                            if(val!.isEmpty) return "value des nai oak thu";
                                                          },
                                                          controller: _startDateCourseController,
                                                          readOnly: true,
                                                          // Make the field read-only to prevent manual input
                                                          onTap: () => _selectStartDate(context),
                                                          decoration: const InputDecoration(
                                                            labelText: 'Start Date',
                                                            hintText: 'Select a date',
                                                            suffixIcon: Icon(Icons.calendar_today),
                                                            border: OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 100,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: TextFormField(
                                                          validator: (val){
                                                            if(val!.isEmpty) return "value des nai oak thu";
                                                          },
                                                          controller: _endDateCourseController,
                                                          readOnly: true,
                                                          onTap: () => _selectEndDate(context),
                                                          decoration: const InputDecoration(
                                                            labelText: 'End Date',
                                                            hintText: 'Select an end date',
                                                            suffixIcon: Icon(Icons.calendar_today),
                                                            border: OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // TextFormField(),
                                                //TextFormField(),
                                              ],
                                            ),
                                          ));
                                    },
                                    child: buildDashboardCard(
                                      title: 'Create Course',
                                      subtitle: 'Create Assignment',
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
                                      title: 'Batch Info',
                                      subtitle: 'Check and Edit Batch Info',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Scheduling',
                                      subtitle: 'View or Add batch Schedule',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: buildDashboardCard(
                                      title: 'Course Information',
                                      subtitle: 'View and Update All courses',
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

  Future<void> postCourse(var courseInfo) async {

    String? token = getTokenFromLocalStorage();
    String? url = 'http://localhost:8090/course/create';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String? getBatchIdInLocalStorage() {
      final storage = html.window.localStorage;
      return storage['batchId'];
    }
    int tempBatchId =  int.parse(getBatchIdInLocalStorage()!);

    final data = {
      "courseName": courseInfo['courseName'],
      "description": courseInfo['description'],
      "startDate": courseInfo['startDate'],
      "endDate": courseInfo['endDate'],
      "batchId": tempBatchId,

    };
    final jsonBody = jsonEncode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      print(response.body);
      print('Data posted successfully');
      Navigator.pop(context);
    } else {
      // Error occurred while posting data
      print('Error occurred while posting data: ${response.body}');
    }
  }

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

  String dateFormatter(String date){
    return DateFormat('dd MMMM, yyyy').format(DateTime.parse(date));

  }
}
