import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:training_management_system/components/screen_size.dart';

import '../../components/color.dart';
import '../../menu/menu_item.dart';
import '../../provider/admin_dashboard_provider.dart';

class BatchList extends StatelessWidget {
  final void Function(MenuItem) onMenuItemSelected;

  BatchList({
    required this.onMenuItemSelected,
    super.key,
  });

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
    return Consumer<AdminDashboardProvider>(builder: (context, adminProvider, child){
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: FutureBuilder<List<dynamic>>(
          future: adminProvider.getBatch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Create a list of batches with 3 batches in each row
              return ListView.builder(
                itemCount: snapshot.data!.length+1,

                  itemBuilder: (context,index){
                    print(snapshot.data!.length);
                    if(index == snapshot.data!.length){
                      return TextButton(
                          onPressed: (){
                            QuickAlert.show(
                                onConfirmBtnTap: (){
                                  if(_batchFormKey.currentState!.validate()){
                                    var batchData = {
                                      'name': _batchName.text,
                                      'start_date': _startDateController.text,
                                      'end_date': _endDateController.text,
                                    };
                                    adminProvider.postBatch(batchData, context);
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

                      }, child: Text("data"));
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical:8),
                      child: Container(
                        height: height(context)*.15,
                          width: width(context)*.2,
                          color: primary.withOpacity(.15),
                          child: InkWell(
                            onTap: (){
                              String batchId = (snapshot.data![index]['batchId']).toString();
                              adminProvider.saveBatchIdInLocalStorage(batchId);
                              onMenuItemSelected(MenuItem.BatchInformation);
                            },
                              child: Text(snapshot.data![index]["batchName"]))),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("error khaise ekhane --${snapshot.error}");
            }
            // By default, show a loading spinner
            return const CircularProgressIndicator();
          },
        ),
      );
    });
  }
}