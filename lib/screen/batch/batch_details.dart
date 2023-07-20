import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/admin/batch_details_provider.dart';
import 'package:http/http.dart' as http;
import "package:universal_html/html.dart" as html;
import '../../components/box_decorations.dart';
import '../../components/color.dart';
import '../../components/my_app_bar.dart';
import '../../components/screen_size.dart';
import '../../components/text_style.dart';

class BatchDetails extends StatefulWidget {
  const BatchDetails({Key? key}) : super(key: key);

  @override
  _BatchDetailsState createState() => _BatchDetailsState();
}

class _BatchDetailsState extends State<BatchDetails> {

  final _updateBatchFormKey = GlobalKey<FormState>();
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _endDateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BatchDetailsProvider>(
      builder: (context, batchDetailsProvider, child) {
        return Scaffold(
          appBar: MyAppBar(
            title: 'TMS: Batch Details',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width(context)* 1,
                  height: height(context) * 1,
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
                                color: Colors.grey[200], // Set the background color of the container
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: FutureBuilder<dynamic>(
                                future: batchDetailsProvider.getBatchByBatchId(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    var batchInfo = snapshot.data!;
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Batch Name: ${batchInfo["batchName"]}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Start Date: ${batchInfo["startDate"]}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'End Date: ${batchInfo["endDate"]}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: 30),
                                        ElevatedButton(
                                          onPressed: () {

                                          },
                                          child: Text(
                                            'Update',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue, // You can change the button color as desired
                                          ),
                                        ),
                                      ],
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
}


