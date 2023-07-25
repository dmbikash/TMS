import 'package:flutter/material.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:training_management_system/components/batch_info_cards.dart';
import 'package:training_management_system/components/color.dart';
import 'package:training_management_system/jhaka_nakatest/mid.dart';
import 'package:training_management_system/landing_screen/right_widget.dart';
import 'package:training_management_system/screen/batch/batchlist.dart';
import 'package:training_management_system/screen/create_user_tms/create_trainer_form.dart';

import '../components/text_style.dart';
import '../menu/menu_item.dart';
import '../screen/batch/add_trainee_to_batch.dart';
import '../screen/batch/add_trainer_to_batch.dart';
import '../screen/batch/batch_details.dart';
import '../screen/batch/batch_information.dart';
import '../screen/batch/course_info_of_batch.dart';
import '../screen/create_user_tms/create_admin_form.dart';
import '../screen/create_user_tms/create_trainee_form.dart';
import '../screen/page1_aluu.dart';
import '../screen/page2_potol.dart';




class LandingScreen extends StatefulWidget {
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool flag = false;
  final _middleContentWidgetKey = GlobalKey<_MiddleContentWidgetState>();



  void onMenuItemSelected(MenuItem menuItem) {

    switch (menuItem) {

      case MenuItem.CourseInfoPage:
        _middleContentWidgetKey.currentState?.changeContent(CourseInfoPage());
        break;

      case MenuItem.BatchDetailsPage:
        _middleContentWidgetKey.currentState?.changeContent(BatchDetailsPage());
        break;

      case MenuItem.AddTrainerToBatch:
      _middleContentWidgetKey.currentState?.changeContent(AddTrainerToBatch());
      break;

      case MenuItem.AddTraineeToBatch:
        _middleContentWidgetKey.currentState?.changeContent(AddTraineeToBatch());
        break;

      case MenuItem.BatchInformation:
        CardsOfBatchInfo cardsOfBatchInfo = CardsOfBatchInfo();
        _middleContentWidgetKey.currentState?.changeContent(BatchInformation(onMenuItemSelected: onMenuItemSelected, cardsOfBatchInfo: cardsOfBatchInfo,));
        break;

      case MenuItem.BatchList:
        _middleContentWidgetKey.currentState?.changeContent(BatchList(onMenuItemSelected: onMenuItemSelected,));
        break;

      case MenuItem.Batchdekhabo:
        _middleContentWidgetKey.currentState?.changeContent(Batchdekhabo(onMenuItemSelected: onMenuItemSelected));
        break;

      case MenuItem.aluu:
        _middleContentWidgetKey.currentState?.changeContent(ALUUContent());
        break;

      case MenuItem.createAdmin:
        _middleContentWidgetKey.currentState?.changeContent(CreateAdminForm());
        break;
      case MenuItem.createTrainee:
        _middleContentWidgetKey.currentState?.changeContent(CreateTraineeForm());
        break;
      case MenuItem.createTrainer:
        _middleContentWidgetKey.currentState?.changeContent(CreateTrainerForm());
        break;
      case MenuItem.logout:
        _middleContentWidgetKey.currentState?.changeContent(ALUUContent());
        break;
      case MenuItem.profile:
        _middleContentWidgetKey.currentState?.changeContent(ALUUContent());
        break;
      case MenuItem.batch:
        _middleContentWidgetKey.currentState?.changeContent(ALUUContent());
        break;

      case MenuItem.potol:
        _middleContentWidgetKey.currentState?.changeContent(PotolContent());
        break;

    // Add cases for other menu items
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: flag ?Container(
      height: 100,
      width: 200,

      child: FloatingActionButton(

        backgroundColor: Colors.black,
        child: Text("ADD BATCH",style: sweet20,),
        onPressed: () {
          // QuickAlert.show(
          //     onConfirmBtnTap: (){
          //       if(_batchFormKey.currentState!.validate()){
          //         adminProvider.postBatch({
          //           'name': _batchName.text,
          //           'start_date': _startDateController.text,
          //           'end_date': _endDateController.text,
          //         },
          //             context
          //         );
          //       }
          //     },
          //     context: context,
          //     type: QuickAlertType.info,
          //     confirmBtnColor: sweetYellow,
          //     confirmBtnText: "Create",
          //     title: "Batch Info",
          //     //customAsset: FlutterLogo(),
          //
          //     widget: Form(
          //       key: _batchFormKey,
          //       child: Column(
          //         children: [
          //           TextFormField(
          //             validator: (val){
          //               if(val!.isEmpty) return "value des nai oak thu";
          //             },
          //             controller: _batchName,
          //             decoration: InputDecoration(hintText: "Batch Name"),
          //           ),
          //           Container(
          //             height: 100,
          //             width: 500,
          //             //color: Colors.red,
          //             child: Row(
          //               children: [
          //                 Expanded(
          //                   flex: 1,
          //                   child: TextFormField(
          //                     validator: (val){
          //                       if(val!.isEmpty) return "value des nai oak thu";
          //                     },
          //                     controller: _startDateController,
          //                     readOnly: true,
          //                     // Make the field read-only to prevent manual input
          //                     onTap: () => _selectStartDate(context),
          //                     decoration: const InputDecoration(
          //                       labelText: 'Start Date',
          //                       hintText: 'Select a date',
          //                       suffixIcon: Icon(Icons.calendar_today),
          //                       border: OutlineInputBorder(),
          //                     ),
          //                   ),
          //                 ),
          //                 const SizedBox(
          //                   width: 100,
          //                 ),
          //                 Expanded(
          //                   flex: 1,
          //                   child: TextFormField(
          //                     validator: (val){
          //                       if(val!.isEmpty) return "value des nai oak thu";
          //                     },
          //                     controller: _endDateController,
          //                     readOnly: true,
          //                     onTap: () => _selectEndDate(context),
          //                     decoration: const InputDecoration(
          //                       labelText: 'End Date',
          //                       hintText: 'Select an end date',
          //                       suffixIcon: Icon(Icons.calendar_today),
          //                       border: OutlineInputBorder(),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           // TextFormField(),
          //           //TextFormField(),
          //         ],
          //       ),
          //     ));
        },

      ),
    )
      : Container(),

     //appBar: AppBar(title: const Text('Dynamic Content Switching')),
      body: Row(
        children: [
          // Menu section
          Expanded(
            flex: 1,
            child: MenuWidget(onMenuItemSelected: onMenuItemSelected),
          ),
          // Middle content section
          Expanded(
            flex: 3,
            child: MiddleContentWidget(key: _middleContentWidgetKey),
          ),
          // Last section
          Expanded(
            flex: 1,
            child: LastContentWidget(),
          ),
        ],
      ),
    );
  }
}


///   DYNAMIC MID SECTION

class MiddleContentWidget extends StatefulWidget {
  MiddleContentWidget({Key? key}) : super(key: key);

  @override
  _MiddleContentWidgetState createState() => _MiddleContentWidgetState();
}

class _MiddleContentWidgetState extends State<MiddleContentWidget> {
  Widget _currentContent = Container(
    child:  Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   child: Text(""),
            //   height: 50,
            //   width: double.infinity,
            //   color: sweetYellow,
            // ),
            Text("I LOVE KHALISI"),
            SizedBox(height: 500,),
            Text("I LOVE KHALISI"),
            SizedBox(height: 500,),
          ],
        ),
      ),
    ),
  ); // Initial content (can be any widget)

  void changeContent(Widget newContent) {
    setState(() {
      _currentContent = newContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _currentContent,
    );
  }
}

