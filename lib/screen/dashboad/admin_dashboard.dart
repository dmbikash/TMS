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

import '../batch/batchlist.dart';
import 'dashboard_components/admin_side_menu.dart';

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
                      adminProvider.postBatch({
                        'name': _batchName.text,
                        'start_date': _startDateController.text,
                        'end_date': _endDateController.text,
                      },
                      context
                      );
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
                      child: AdminSideMenu(),
                    ),
                    //body
                    // Expanded(
                    //   flex: 4,
                    //   child: BatchList(),
                    // ),

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



}




