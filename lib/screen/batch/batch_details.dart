import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:universal_html/html.dart' as html;
import '../../components/color.dart';
import '../../components/screen_size.dart';
import '../../provider/batch_details_provider.dart';

class BatchDetailsPage extends StatelessWidget {
  BatchDetailsPage({
    super.key,
  });




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
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: width(context) * 0.3,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: height(context),
                              width: width(context) * .5,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                // Set the background color of the container
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FutureBuilder<dynamic>(
                                future:
                                    batchDetailsProvider.getBatchByBatchId(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    var batchInfo = snapshot.data!;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                      batchDetailsProvider.getRoleFromLocalStorage()=="ADMIN"? ElevatedButton(
                                          onPressed: () {
                                            QuickAlert.show(
                                                onConfirmBtnTap: () {
                                                  if (_updateBatchFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    batchDetailsProvider
                                                        .updateBatch({
                                                      'name': _batchName.text,
                                                      'start_date':
                                                          _startDateController
                                                              .text,
                                                      'end_date':
                                                          _endDateController
                                                              .text,
                                                    }, context);
                                                  }
                                                },
                                                context: context,
                                                type: QuickAlertType.info,
                                                confirmBtnColor: sweetYellow,
                                                confirmBtnText: "Update",
                                                title: "Update Batch Info",
                                                //customAsset: FlutterLogo(),

                                                widget: Form(
                                                  key: _updateBatchFormKey,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        validator: (val) {
                                                          if (val!.isEmpty)
                                                            return "null";
                                                        },
                                                        controller: _batchName,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Batch Name"),
                                                      ),
                                                      Container(
                                                        height: 100,
                                                        width: 500,
                                                        //color: Colors.red,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (val) {
                                                                  if (val!
                                                                      .isEmpty)
                                                                    return "null";
                                                                },
                                                                controller:
                                                                    _startDateController,
                                                                readOnly: true,
                                                                onTap: () =>
                                                                    _selectStartDate(
                                                                        context),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  labelText:
                                                                      'Start Date',
                                                                  hintText:
                                                                      'Select a date',
                                                                  suffixIcon:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 100,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (val) {
                                                                  if (val!
                                                                      .isEmpty)
                                                                    return "null";
                                                                },
                                                                controller:
                                                                    _endDateController,
                                                                readOnly: true,
                                                                onTap: () =>
                                                                    _selectEndDate(
                                                                        context),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  labelText:
                                                                      'End Date',
                                                                  hintText:
                                                                      'Select an end date',
                                                                  suffixIcon:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  border:
                                                                      OutlineInputBorder(),
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
                                          child: Text(
                                            'Update',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .blue, // You can change the button color as desired
                                          ),
                                        )
                                        :SizedBox(),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: width(context) * .3,
                              height: height(context) * 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Trainer List',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Expanded(
                                    child: FutureBuilder<List<dynamic>>(
                                      future: batchDetailsProvider
                                          .getTrainerListByBatchId(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return CircularProgressIndicator();
                                        } else {
                                          var trainerList = snapshot.data!;
                                          return Container(
                                            child: DataTable(
                                              columnSpacing: 15,
                                              headingRowHeight: 40,
                                              dataRowHeight: 50,
                                              dividerThickness: 1,
                                              showBottomBorder: true,
                                              columns: const [
                                                DataColumn(
                                                    label: Text('Name',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('Email',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('Designation',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text(
                                                        'Contact\nNumber',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ],
                                              rows: trainerList.map((trainer) {
                                                return DataRow(cells: [
                                                  DataCell(Text(
                                                      trainer["fullName"])),
                                                  DataCell(
                                                      Text(trainer["email"])),
                                                  DataCell(Text(
                                                      trainer["designation"])),
                                                  DataCell(Text(trainer[
                                                      "contactNumber"])),
                                                ]);
                                              }).toList(),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: width(context) * .3,
                    height: height(context) * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Trainee Info',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder<List<dynamic>>(
                            future:
                                batchDetailsProvider.getTraineeListByBatchId(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              } else {
                                var trainerList = snapshot.data!;
                                return DataTable(
                                  columnSpacing: 15,
                                  headingRowHeight: 40,
                                  dataRowHeight: 50,
                                  dividerThickness: 1,
                                  showBottomBorder: true,
                                  columns: const [
                                    DataColumn(
                                        label: Text('Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Email',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Educational\nInstitute',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('Contact\nNumber',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                  ],
                                  rows: trainerList.map((trainer) {
                                    return DataRow(cells: [
                                      DataCell(Text(trainer["fullName"])),
                                      DataCell(Text(trainer["email"])),
                                      DataCell(Text(
                                          trainer["educationalInstitute"])),
                                      DataCell(Text(trainer["contactNumber"])),
                                    ]);
                                  }).toList(),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
