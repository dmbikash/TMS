
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/components/screen_size.dart';
import '../menu/trainer_menu_item.dart';
import '../provider/batch_info_trainer_provider.dart';

class BatchInformationTrainer extends StatelessWidget {

  final void Function(TrainerMenuItem) onMenuItemSelected;

   BatchInformationTrainer(
       {Key? key,
    required this.onMenuItemSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BatchInfoTrainerProvider>(
      builder: (context, batchInfoTrainerProvider, child){
        return  Padding(
          padding: const EdgeInsets.fromLTRB(100, 60, 0, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .start,
                children: [
                  InkWell(
                    onTap: () {
                      onMenuItemSelected(TrainerMenuItem.ClassRoom);
                    },
                    child: buildDashboardCard(
                      title: 'Classroom',
                      subtitle: 'Create post or notice',
                      context: context,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: buildDashboardCard(
                      title: 'Group Chat',
                      subtitle: 'Join the Group Chat',
                      context: context,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                     onMenuItemSelected(TrainerMenuItem.AssignmentTrainer);
                    },
                    child: buildDashboardCard(
                      title: 'Assignment',
                      subtitle: 'Create Assignment',
                      context: context,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .start,
                children: [
                  InkWell(
                    onTap: () {
                     onMenuItemSelected(TrainerMenuItem.CourseInfoTrainer);
                    },
                    child: buildDashboardCard(
                      title: 'Courses',
                      subtitle: 'Explore Courses',
                      context: context,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onMenuItemSelected(TrainerMenuItem.BatchDetailsPage);
                    },
                    child: buildDashboardCard(
                      title: 'Batch Details',
                      subtitle: 'View batch Details',
                      context: context,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onMenuItemSelected(TrainerMenuItem.ScheduleTrainer);
                    },
                    child: buildDashboardCard(
                      title: 'Schedule',
                      subtitle: 'View batch Schedule',
                      context: context,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}


Widget buildDashboardCard({required String title, required String subtitle, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: width(context) * 0.16,
      height: height(context) * 0.25,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Go to $title',
                    style: TextStyle(fontSize: 10),
                  ),
                  Icon(Icons.arrow_forward, size: 14),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
