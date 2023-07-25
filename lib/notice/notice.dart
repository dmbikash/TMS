import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/notice%20provider.dart';

class Notice extends StatelessWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeProvider>(
      builder:(context, noticeProvider, child){
        return Container(
          //color: Colors.blueAccent,
          //height: 400,
          child: FutureBuilder<List<dynamic>>(
            future: noticeProvider.getAllNotice(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Text("sometihnmg went wronmg");
              }
              if(snapshot.data!.isEmpty){
                return Center(child: Container(child: Text("No Notice")));
              }
              return ListView.builder(
                itemCount:snapshot.data!.length,
                itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    //height: 100,
                    width: 400,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(color: Colors.black54,width: 5)
                    ),
                    child: Card(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Notice ${snapshot.data![index]["noticeId"]}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(" ${snapshot.data![index]["textData"]}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )),
                  ),
                );
              },
              );
            },
          ),
        );
      }
    );
  }
}
