import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/screen_size.dart';
import '../provider/course_info_trainer_provider.dart';


class CourseInfoTrainer extends StatelessWidget {
  const CourseInfoTrainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseInfoTrainerProvider>(
      builder: (context, courseInfoTrainerProvider, child){
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: height(context),
            width: width(context) * .5,
            decoration: BoxDecoration(
              color: Colors.grey[200], // Set the background color of the table
              borderRadius: BorderRadius.circular(12),
            ),
            child: FutureBuilder<List<dynamic>>(
              future: courseInfoTrainerProvider.getCoursesByBatchId(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 80,
                        headingRowHeight: 70,
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        columns: const [
                          DataColumn(
                            label: Text('Course Name'),
                          ),
                          DataColumn(
                            label: Text('Start Date'),
                          ),
                          DataColumn(
                            label: Text('End Date'),
                          ),
                        ],
                        rows: snapshot.data!.map((course) {
                          return DataRow(cells: [
                            DataCell(Text(course["courseName"])),
                            DataCell(Text(course["startDate"])),
                            DataCell(Text(course["endDate"])),
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );













    //—--------------------------------------------------





   // ;
  }
}
