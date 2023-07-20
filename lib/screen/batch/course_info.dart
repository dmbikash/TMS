import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:training_management_system/provider/admin/course_info_provider.dart';
import 'package:http/http.dart' as http;
import "package:universal_html/html.dart" as html;
import '../../components/box_decorations.dart';
import '../../components/color.dart';
import '../../components/my_app_bar.dart';
import '../../components/screen_size.dart';
import '../../components/text_style.dart';

class CourseInfo extends StatefulWidget {
  const CourseInfo({Key? key}) : super(key: key);

  @override
  _CourseInfoState createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {

  final _courseUpdateFormKey = GlobalKey<FormState>();
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _endDateCourseController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseInfoProvider>(
      builder: (context, courseInfoProvider, child) {
        return Scaffold(
          appBar: MyAppBar(
            title: 'TMS: Course Info',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width(context)* 1,
                  height: height(context) * .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 38.0),
                            child: Container(
                              height: height(context) * .80,
                              decoration: box12Sidebar,
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
                      ),
                      //body
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              height: height(context),
                              width: width(context) * .5,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Set the background color of the table
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FutureBuilder<List<dynamic>>(
                                future: Provider.of<CourseInfoProvider>(context).getCoursesByBatchId(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          dataRowMaxHeight: 80,
                                          headingRowHeight: 70,
                                          headingTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          columns: [
                                            DataColumn(
                                              label: Text('Course Name'),
                                            ),
                                            DataColumn(
                                              label: Text('Start Date'),
                                            ),
                                            DataColumn(
                                              label: Text('End Date'),
                                            ),
                                            DataColumn(
                                              label: Text('Update'),
                                            ),
                                          ],
                                          rows: snapshot.data!.map((course) {
                                            return DataRow(cells: [
                                              DataCell(Text(course["courseName"])),
                                              DataCell(Text(course["startDate"])),
                                              DataCell(Text(course["endDate"])),
                                              DataCell(
                                                IconButton(
                                                  onPressed: () {
                                                    QuickAlert.show(
                                                        onConfirmBtnTap: (){
                                                          if(_courseUpdateFormKey.currentState!.validate()){
                                                            courseInfoProvider.updateCourse({
                                                              'courseId' : course["courseId"],
                                                              'courseName': _courseName.text,
                                                              'description': _description.text,
                                                              'startDate': _startDateCourseController.text,
                                                              'endDate': _endDateCourseController.text,
                                                            }, context);
                                                          }
                                                        },
                                                        context: context,
                                                        type: QuickAlertType.info,
                                                        confirmBtnColor: sweetYellow,
                                                        confirmBtnText: "Update",
                                                        title: "Update Course",

                                                        widget: Form(
                                                          key: _courseUpdateFormKey,
                                                          child: Column(
                                                            children: [

                                                              TextFormField(
                                                                validator: (val){
                                                                  if(val!.isEmpty) return "null value";
                                                                },
                                                                controller: _courseName,
                                                                decoration: InputDecoration(hintText: "Course Name"),
                                                              ),

                                                              TextFormField(
                                                                validator: (val){
                                                                  if(val!.isEmpty) return "null value";
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
                                                                          if(val!.isEmpty) return "null value";
                                                                        },
                                                                        controller: _startDateCourseController,
                                                                        readOnly: true,

                                                                        onTap: () => _selectStartDate(context),
                                                                        decoration: const InputDecoration(
                                                                          labelText: 'Start Date',
                                                                          hintText: 'Select a start date',
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
                                                                          if(val!.isEmpty) return "null value";
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
                                                        )
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.update_sharp,
                                                    color: Colors.black87, // You can change the color as desired
                                                  ),
                                                ),
                                              ),
                                            ]);
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                        ),
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




  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

}
