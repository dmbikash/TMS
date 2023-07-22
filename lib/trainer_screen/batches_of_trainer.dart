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
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<dynamic>>(
              future: batchesOfTrainerProvider.getBatchListByTrainerId(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Create a list of batches with 3 batches in each row
                  return ListView.builder(
                      itemCount: snapshot.data!.length,

                      itemBuilder: (context,index){
                        print(snapshot.data!.length);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical:8),
                          child: Container(
                              height: height(context)*.15,
                              width: width(context)*.2,
                              color: primary.withOpacity(.15),
                              child: InkWell(
                                  onTap: (){
                                    String batchId = (snapshot.data![index]['batchId']).toString();
                                    batchesOfTrainerProvider.saveBatchIdInLocalStorage(batchId);
                                    print("trainer er batch list theke batchid print hochhe  $batchId");
                                    widget.onMenuItemSelected(TrainerMenuItem.batchInfo);
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
        }
    );
  }
}
