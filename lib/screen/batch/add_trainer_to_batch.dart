import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:training_management_system/components/box_decorations.dart';
import 'package:training_management_system/components/color.dart';
import 'package:training_management_system/components/screen_size.dart';
import 'package:training_management_system/provider/addTrainerToBatch_provider.dart';

import '../../components/my_app_bar.dart';
import '../../components/text_style.dart';

class AddTrainerToBatch extends StatefulWidget {

   AddTrainerToBatch({Key? key,}) : super(key: key);

  @override
  State<AddTrainerToBatch> createState() => _AddTrainerToBatchState();
}

class _AddTrainerToBatchState extends State<AddTrainerToBatch> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTrainerToBatchProvider>(
      builder: (context, addTrainerToBatchProvider, child) {
        return Scaffold(
          appBar: MyAppBar(
            title: 'TMS: Add Trainer to Batch',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width(context) * 1,
                  height: height(context) * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 38.0),
                            child: Container(
                              height: height(context) * .80,
                              decoration: box12Sidebar,
                              //color: Colors.orangeAccent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
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
                                    onTap: () {
                                      //Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, "AdminDashboard");
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
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "TraineeRegister");
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
                                future: addTrainerToBatchProvider.getTrainers(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical, // Enable vertical scrolling
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                                        child: DataTable(
                                          dataRowHeight: 60,
                                          headingRowHeight: 70,
                                          headingTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          columns: [
                                            DataColumn(
                                              label: Text('Name'),
                                            ),
                                            DataColumn(
                                              label: Text('Designation'),
                                            ),
                                            DataColumn(
                                              label: Text('Email'),
                                            ),
                                            DataColumn(
                                              label: Text('Add'),
                                            ),
                                          ],
                                          rows: snapshot.data!.map((trainer) {
                                            return DataRow(cells: [
                                              DataCell(Text(trainer["fullName"])),
                                              DataCell(Text(trainer["designation"])),
                                              DataCell(Text(trainer["email"])),
                                              DataCell(
                                                IconButton(
                                                  onPressed: () {
                                                    addTrainerToBatchProvider.addToSelectedTrainers(trainer["trainerId"]);
                                                    var batchInfo = {
                                                      "trainerId": trainer["trainerId"],
                                                      "batchId": int.parse(getBatchIdInLocalStorage()!),
                                                    };
                                                    print(int.parse(getBatchIdInLocalStorage()!));
                                                    addTrainerToBatchProvider.postTrainerToBatch(batchInfo);
                                                  },
                                                  icon: Icon(Icons.add_box),
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
      }
    );
  }


  String? getBatchIdInLocalStorage() {
    final storage = html.window.localStorage;
    return storage['batchId'];
  }
}



