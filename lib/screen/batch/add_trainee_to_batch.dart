import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/admin/addTraineeToBatch_provider.dart';
import 'package:universal_html/html.dart' as html;

import '../../components/box_decorations.dart';
import '../../components/color.dart';
import '../../components/my_app_bar.dart';
import '../../components/screen_size.dart';
import '../../components/text_style.dart';

class AddTraineeToBatch extends StatefulWidget {

  AddTraineeToBatch({Key? key,}) : super(key: key);

  @override
  State<AddTraineeToBatch> createState() => _AddTraineeToBatchState();
}

class _AddTraineeToBatchState extends State<AddTraineeToBatch> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTraineeToBatchProvider>(
        builder: (context, addTraineeToBatchProvider, child) {
          return Scaffold(
            appBar: MyAppBar(
              title: 'TMS: Add Trainee to Batch',
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width(context) * 1,
                    height: height(context) * .9,
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
                                  future: addTraineeToBatchProvider.getTrainees(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      print("nai kichu");
                                      return CircularProgressIndicator();
                                    } else {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                                        child: DataTable(
                                          dataRowMaxHeight: 80,
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
                                              label: Text('Email'),
                                            ),
                                            DataColumn(
                                              label: Text('Educational Institute'),
                                            ),
                                            DataColumn(
                                              label: Text('Add'),
                                            ),
                                          ],
                                          rows: snapshot.data!.map((trainee) {
                                            return DataRow(cells: [
                                              DataCell(Text(trainee["fullName"])),
                                              DataCell(Text(trainee["email"])),
                                              DataCell(Text(trainee["educationalInstitute"])),
                                              DataCell(
                                                IconButton(
                                                  onPressed: () {
                                                    addTraineeToBatchProvider.addToSelectedTrainees(trainee["traineeId"]);
                                                    var batchInfo = {
                                                      "traineeId": trainee["traineeId"],
                                                      "batchId": int.parse(getBatchIdInLocalStorage()!),
                                                    };
                                                    print(int.parse(getBatchIdInLocalStorage()!));
                                                    addTraineeToBatchProvider.postTraineeToBatch(batchInfo);
                                                  },
                                                  icon: Icon(Icons.add_box),
                                                ),
                                              ),
                                            ]);
                                          }).toList(),
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
