import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:training_management_system/components/box_decorations.dart';
import 'package:training_management_system/components/color.dart';
import 'package:training_management_system/components/text_style.dart';
import 'package:training_management_system/provider/admin_dashboard_provider.dart';
import '../../components/my_app_bar.dart';
import '../../components/screen_size.dart';
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
          title: 'Dashboard: ADMIN',
        ),

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
                    //side menu
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: FutureBuilder<List<dynamic>>(
                          future: adminProvider.getBatch(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // Create a list of batches with 3 batches in each row
                              List<Widget> rowsOfCards = [];
                              int batchSize = 3;
                              int totalBatches = snapshot.data!.length;
                              double maxWidth = width(context) * 0.5/3; // Maximum width for each card
                              for (int i = 0; i < totalBatches; i += batchSize) {
                                int endIndex = i + batchSize;
                                if (endIndex > totalBatches) {
                                  endIndex = totalBatches;
                                }

                                List<Widget> rowChildren = [];
                                for (int j = i; j < endIndex; j++) {
                                  rowChildren.add(
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          String batchId = (snapshot.data![j]['batchId']).toString();
                                          saveBatchIdInLocalStorage(batchId);
                                          Navigator.pushNamed(context, 'AdminBatchInfo');
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(maxWidth: maxWidth),
                                          decoration: box12,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${snapshot.data![j]['batchName']}',
                                                style: black40,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Batch ID: ${snapshot.data![j]['batchId']}",
                                                style: grey20,
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                                ),
                                                height: 2,
                                              ),
                                              SizedBox(height: 10),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Start: ${dateFormatter(snapshot.data![j]['startDate'])}",
                                                    style: grey20,
                                                  ),
                                                  Text(
                                                    "End : ${dateFormatter(snapshot.data![j]['endDate'])}",
                                                    style: grey20,
                                                  ),
                                                  Text(
                                                    "Total Trainers : ${(snapshot.data![j]['trainers'].length)}      ",
                                                    style: black20,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                rowsOfCards.add(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: rowChildren,
                                  ),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  //color: Colors.green,
                                  child: Column(
                                    children: rowsOfCards,
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("error khaise ekhane --${snapshot.error}");
                            }
                            // By default, show a loading spinner
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
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

    String? token = getTokenFromLocalStorage();
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

  String? getTokenFromLocalStorage() {
    final storage = html.window.localStorage;
    return storage['token'];
  }

  String dateFormatter(String date){
    return DateFormat('dd MMMM, yyyy').format(DateTime.parse(date));

  }

  void saveBatchIdInLocalStorage(String batchId) {
    final storage = html.window.localStorage;
    storage['batchId'] = batchId;
  }

  String? getBatchIdInLocalStorage() {
    final storage = html.window.localStorage;
    return storage['batchId'];
  }

}
