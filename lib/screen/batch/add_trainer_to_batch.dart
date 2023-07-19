import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:training_management_system/components/box_decorations.dart';
import 'package:training_management_system/components/color.dart';
import 'package:training_management_system/components/screen_size.dart';
import 'package:training_management_system/provider/AddTrainerToBatch_provider.dart';

class AddTrainerToBatch extends StatefulWidget {

   AddTrainerToBatch({
   Key? key,

   }) : super(key: key);

  @override
  State<AddTrainerToBatch> createState() => _AddTrainerToBatchState();
}

class _AddTrainerToBatchState extends State<AddTrainerToBatch> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AddTrainerToBatchProvider>(
        builder: (context, addTrainerToBatchProvider, child){
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: height(context),
                      width: width(context)*.5,
                      //color: Colors.red,
                      child: FutureBuilder<List<dynamic>>(
                        future: addTrainerToBatchProvider.getTrainers(),
                        builder: (context, snapshot){
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: addTrainerToBatchProvider.isSelected(snapshot.data![index]["trainerId"])? Colors.lightGreen.withOpacity(.45) : Colors.white,

                                      border: Border.all(width: 5,
                                          color: addTrainerToBatchProvider.isSelected(snapshot.data![index]["trainerId"])
                                              ? Colors.lightGreen.withOpacity(.85)
                                              :Colors.redAccent.withOpacity(.45)),
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: ListTile(
                                      title: Text(snapshot.data![index]["fullName"]),
                                      trailing: IconButton(
                                        onPressed: () {
                                          addTrainerToBatchProvider.addToSelectedTrainers(snapshot.data![index]["trainerId"]);
                                          var batchInfo = {
                                            "trainerId" : snapshot.data![index]["trainerId"],
                                            "batchId" : int.parse(getBatchIdInLocalStorage()!),
                                          };
                                          print(int.parse(getBatchIdInLocalStorage()!));
                                          addTrainerToBatchProvider.postTrainerToBatch(batchInfo);

                                        },
                                        icon: Icon(Icons.add),

                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        },

                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  String? getBatchIdInLocalStorage() {
    final storage = html.window.localStorage;
    return storage['batchId'];
  }
}
