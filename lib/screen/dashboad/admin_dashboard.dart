import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart'; // Import the intl package

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_management_system/components/box_decorations.dart';
import 'package:training_management_system/components/color.dart';
import 'package:training_management_system/components/text_style.dart';
import 'package:training_management_system/main.dart';
import 'package:training_management_system/provider/admin_dashboard_provider.dart';
import '../../components/my_app_bar.dart';
import '../../components/screen_size.dart';
import 'dashboard_components/drawyer.dart';
import "package:universal_html/html.dart" as html;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _batchFormKey = GlobalKey<FormState>();
  final _batchName = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
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
      _startDateController.text = formattedDate;
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
      _endDateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminDashboardProvider>(
        builder: (context, adminProvider, child) {
      return Scaffold(
        //backgroundColor: Color(0xFF3C4043),
        appBar: MyAppBar(
          title: 'Dashboard',
        ),
        // drawer: const SizedBox(
        //   width: 250,
        //   child: Drawyer(),
        // ),
        floatingActionButton: Container(
          height: 100,
          width: 200,

          child: FloatingActionButton(

            backgroundColor: Colors.black,
            child: Text("ADD BATCH",style: sweet20,),
            onPressed: () {
              QuickAlert.show(
                onConfirmBtnTap: (){
                  if(_batchFormKey.currentState!.validate()){
                      postBatch({
                        'name': _batchName.text,
                        'start_date': _startDateController.text,
                        'end_date': _endDateController.text,
                      });
                    }
                  },
                  context: context,
                  type: QuickAlertType.info,
                  confirmBtnColor: sweetYellow,
                  confirmBtnText: "Create",
                  title: "Batch Info",
                  //customAsset: FlutterLogo(),

                  widget: Form(
                    key: _batchFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val){
                            if(val!.isEmpty) return "value des nai oak thu";
                          },
                          controller: _batchName,
                          decoration: InputDecoration(hintText: "Batch Name"),
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
                                  controller: _startDateController,
                                  readOnly: true,
                                  // Make the field read-only to prevent manual input
                                  onTap: () => _selectDate(context),
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
                                  controller: _endDateController,
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

          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width(context),
                height: height(context) * .90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              onTap: (){},
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
                    Expanded(
                      flex: 4,
                      child: FutureBuilder<List<dynamic>>(
                        future: adminProvider.get_batch(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                //color: Colors.green,
                                child: ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: width(context) * .22,
                                          height: height(context) * .25,
                                          decoration: box12,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${snapshot.data![index]['batchName']}',
                                                        style: black40,
                                                        overflow: TextOverflow.ellipsis,
                                                    ),

                                                    Text(
                                                      'Java SE',
                                                      style: grey20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,

                                                // batch er divider er porer part
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.black54,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      30))),
                                                      height:
                                                          height(context) * .15,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Start Date: ${dateFormatter(snapshot.data![index]['startDate'])}",
                                                          style: grey20,
                                                        ),
                                                        Text(
                                                          "EndDate: ${dateFormatter(snapshot.data![index]['endDate'])}",
                                                          style: grey20,
                                                        ),
                                                        Text(
                                                          "Total Trainers : ${(snapshot.data![index]['trainers'].length)}      ",
                                                          style: black20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                "error khaise ekhane --${snapshot.error}");
                          }
                          // By default, show a loading spinner
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          // color: Colors.purple,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> postBatch(var batchInfo) async {
    //List categoryDataList, BuildContext context;
    //print(categoryDataList[0]);

    String? token = getTokenFromLocalstorage();
    String? url = 'http://localhost:8090/batch/create';
    //print(url!+token!);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final data = {
      "batchName": batchInfo['name'],
      "startDate": batchInfo['start_date'],
      "endDate": batchInfo['end_date'],
      "trainers": null,

    };
    final jsonBody = jsonEncode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      print(response.body);
      // Data posted successfully
      print('Data posted successfully');
      Navigator.pop(context);
    } else {
      // Error occurred while posting data
      print('Error occurred while posting data: ${response.body}');
    }
  }

  String? getTokenFromLocalstorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

  String dateFormatter(String date){
    return DateFormat('dd MMMM, yyyy').format(DateTime.parse(date));

  }


}
