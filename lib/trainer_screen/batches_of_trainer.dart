import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/BatchesOfTrainerProvider.dart';

import '../components/color.dart';
import '../components/screen_size.dart';
import '../menu/trainer_menu_item.dart';

class BatchesOfTrainer extends StatefulWidget {
  final void Function(TrainerMenuItem) onMenuItemSelected;


   BatchesOfTrainer({Key? key,
     required  this.onMenuItemSelected,
   }) : super(key: key);

  @override
  State<BatchesOfTrainer> createState() => _BatchesOfTrainerState();
}

class _BatchesOfTrainerState extends State<BatchesOfTrainer> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<BatchesOfTrainerProvider>(
        builder:(context, batchesOfTrainerProvider, child){
          return Padding(
            padding: EdgeInsets.all(50),
            child: FutureBuilder<List<dynamic>>(
              future: batchesOfTrainerProvider.getBatchListByTrainerId(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Create a list of batches with 3 batches in each row
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Display 3 cards in each row
                      crossAxisSpacing: 16, // Spacing between columns
                      mainAxisSpacing: 16, // Spacing between rows
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var batchData = snapshot.data![index];
                      var batchId = batchData["batchId"].toString();
                      var batchName = batchData["batchName"];
                      var startDate = batchData["startDate"];
                      var endDate = batchData["endDate"];

                      return Card(
                        elevation: 4, // Add some elevation for a slight shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners for the card
                        ),
                        child: InkWell(
                          onTap: () {
                            String batchId = (snapshot.data![index]['batchId']).toString();
                            batchesOfTrainerProvider.saveBatchIdInLocalStorage(batchId);
                            print("trainer er batch list theke batchid print hochhe  $batchId");
                            widget.onMenuItemSelected(TrainerMenuItem.batchInfo);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  batchName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Batch ID: $batchId",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Start Date: $startDate",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "End Date: $endDate",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                // By default, show a loading spinner
                return const CircularProgressIndicator();
              },
            ),
          );

        }
    );
  }
}
