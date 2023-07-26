import 'package:flutter/material.dart';
import 'package:training_management_system/classroom/classroom.dart';
import 'package:training_management_system/notice/notice.dart';
import 'package:training_management_system/provider/assignment_trainer_provider.dart';
import 'package:training_management_system/screen/batch/batch_details.dart';
import 'package:training_management_system/screen/page1_aluu.dart';
import 'package:training_management_system/trainee_screen/assignment_trainee.dart';
import 'package:training_management_system/trainee_screen/batch_information_trainee.dart';
import 'package:training_management_system/trainee_screen/course_info_trainee.dart';
import 'package:training_management_system/trainee_screen/trainee_profile.dart';
import 'package:training_management_system/trainer_screen/schedule_trainer.dart';
import '../landing_screen/right_widget.dart';
import '../menu/trainee_menu_item.dart';


class LandingScreenTrainee extends StatefulWidget {
  const LandingScreenTrainee({Key? key}) : super(key: key);

  @override
  _LandingScreenTraineeState createState() => _LandingScreenTraineeState();
}

class _LandingScreenTraineeState extends State<LandingScreenTrainee> {

  final _middleContentWidgetKey = GlobalKey<_MiddleContentWidgetState>();


  // Function to handle menu item selection
  void onTraineeMenuItemSelected(TraineeMenuItem menuItem) {

    switch (menuItem) {

      case TraineeMenuItem.classroom:
        _middleContentWidgetKey.currentState?.changeContent(ClassroomPage());
        break;

      case TraineeMenuItem.notice:
        _middleContentWidgetKey.currentState?.changeContent(Notice());
        break;

      case TraineeMenuItem.assignmentTrainee:
        _middleContentWidgetKey.currentState?.changeContent(AssignmentTrainee());
        break;

      case TraineeMenuItem.schedule:
        _middleContentWidgetKey.currentState?.changeContent(ScheduleTrainer());
        break;

      case TraineeMenuItem.batchDetailsPage:
        _middleContentWidgetKey.currentState?.changeContent(BatchDetailsPage());
        break;

      case TraineeMenuItem.course:
        _middleContentWidgetKey.currentState?.changeContent(CourseInfoTrainee());
        break;

      case TraineeMenuItem.batch:
        _middleContentWidgetKey.currentState?.changeContent(BatchInformationTrainee(onMenuItemSelected: onTraineeMenuItemSelected,));
        break;

      case TraineeMenuItem.profile:
        _middleContentWidgetKey.currentState?.changeContent(TraineeProfile());
        break;
      case TraineeMenuItem.logout:
        _middleContentWidgetKey.currentState?.changeContent(ALUUContent());
        break;


    // Add cases for other menu items
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appBar: AppBar(title: const Text('Dynamic Content Switching')),
      body: Row(
        children: [
          // Menu section
          Expanded(
            flex: 1,
            child: TraineeMenuWidget(onMenuItemSelected: onTraineeMenuItemSelected),
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

            Text("yo "),
            SizedBox(height: 500,),
            Text("yo "),
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

