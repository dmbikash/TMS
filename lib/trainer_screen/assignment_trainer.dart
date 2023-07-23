import 'dart:html' as htmml;
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:training_management_system/provider/assignment_trainer_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/color.dart';

class AssignmentTrainer extends StatelessWidget {
  AssignmentTrainer({Key? key}) : super(key: key);

  final _createAssignmentFormKey = GlobalKey<FormState>();
  final _description = TextEditingController();
  final _deadline = TextEditingController();
  final _title = TextEditingController();

  Future<void> _selectDeadline(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _deadline.text = formattedDate;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentTrainerProvider>(
        builder: (context, assignmentTrainerProvider, child) {
          return Padding(

            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder<List<dynamic>>(
                future: assignmentTrainerProvider.getAssignmentsByBatchId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    print(snapshot.data);
                    return Center(
                      child: Text("No assignments found."),
                    );
                  } else {
                    List<dynamic> assignments = snapshot.data!;
                    return ListView.builder(
                      itemCount: (assignments.length) + 1,
                      itemBuilder: (context, index) {
                        print(index);
                        if (assignments.length == index) {
                          return ElevatedButton(
                            onPressed: () {
                              QuickAlert.show(
                                  onConfirmBtnTap: () {
                                    if (_createAssignmentFormKey.currentState!
                                        .validate()) {
                                      print(_title.text);

                                      assignmentTrainerProvider
                                          .createAssignment({
                                        'title': _title.text,
                                        'description': _description.text,
                                        'deadline': _deadline.text,

                                      }, context);
                                    }
                                  },
                                  context: context,
                                  type: QuickAlertType.info,
                                  confirmBtnColor: sweetYellow,
                                  confirmBtnText: "Create",
                                  title: "Create Assignment",

                                  widget: Form(
                                    key: _createAssignmentFormKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                validator: (val) {
                                                  if (val!.isEmpty)
                                                    return "Required";
                                                },
                                                controller: _title,
                                                decoration: InputDecoration(
                                                    hintText: "Tittle"),
                                              ),
                                            ),

                                            const SizedBox(
                                              width: 100,
                                            ),

                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                validator: (val) {
                                                  if (val!.isEmpty)
                                                    return "Required";
                                                },
                                                controller: _description,
                                                decoration: InputDecoration(
                                                    hintText: "Description"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 100,
                                          width: 500,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  validator: (val) {
                                                    if (val!.isEmpty)
                                                      return "required";
                                                  },
                                                  controller: _deadline,
                                                  readOnly: true,
                                                  onTap: () =>
                                                      _selectDeadline(context),
                                                  decoration: const InputDecoration(
                                                    labelText: 'Deadline',
                                                    hintText: 'Deadline',
                                                    suffixIcon: Icon(
                                                        Icons.calendar_today),
                                                    border: OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                width: 100,
                                              ),

                                              Expanded(
                                                flex: 1,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    assignmentTrainerProvider
                                                        .pickFile(context);
                                                  },
                                                  child: assignmentTrainerProvider
                                                      .assignment == null
                                                      ? Text("Select File")
                                                      : Icon(
                                                    Icons.check_box_rounded,
                                                    color: Colors.grey,
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
                            child: Text("Create"),
                          );
                        }
                        var assignment = assignments[index];
                        return Card(
                          color: Colors.grey[300],
                          // Grayish background color for the card
                          child: InkWell(
                            onTap: () {
                              // Handle the click event if needed
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    assignment["title"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    assignment["description"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Deadline: ${assignment["deadline"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              //String url = "localhost:8090/assignment/download/1";
                                              //htmml.window.open(url, "CV_Bikash_Flutter Dev.pdf");
                                              String fileUrl = 'http://localhost:8090/assignment/download/${assignments[index]["assignmentId"]}'; // Replace with your file URL
                                              downloadFile(fileUrl);

                                            },
                                            child: Icon(Icons.download)),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Icon(Icons.info)),
                                      ],
                                    ),
                                  ),
                                  // You can add the file widget here
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          );
        });
  }

  void downloadFile(String fileUrl) {
    // Create a new anchor element
    AnchorElement anchor = AnchorElement(href: fileUrl)
      ..target = '_blank' // Open the link in a new tab/window
      ..download = ''; // Set the 'download' attribute to force download

    // Programmatically click the anchor element
    anchor.click();
  }
}
