import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/menu_provider.dart';

import '../components/box_decorations.dart';
import '../components/color.dart';
import '../components/screen_size.dart';
import '../components/text_style.dart';
import '../provider/trainer_menu_provider.dart';
import '../screen/dashboad/dashboard_components/admin_side_menu.dart';

enum TrainerMenuItem {
  profile,
  logout,
  batch,
  batchInfo,
  AssignmentTrainer,
  CourseInfoTrainer,
  BatchDetailsPage,
  ScheduleTrainer

}

class TrainerMenuWidget extends StatelessWidget {
  final void Function(TrainerMenuItem) onMenuItemSelected;

  TrainerMenuWidget({required this.onMenuItemSelected});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainerMenuProvider>(builder: (context, trainerMenuProvider, child){
      return Container(
        //height: 100,
        color: primary,

        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: Container(
            height: height(context) ,
            //decoration: box12Sidebar,
            //color: Colors.orangeAccent,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 80),
                    child: Text('TMS',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 5,
                      ),),
                  ),

                  InkWell(
                    onTap: (){
                      trainerMenuProvider.onClickSideMenu(1);
                      onMenuItemSelected(TrainerMenuItem.profile);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        //decoration: box12Sidebar,
                        child: TextLiquidFill(
                          text: 'Profile',
                          waveColor: trainerMenuProvider.profile? Colors.white : sweetYellow,
                          boxBackgroundColor: trainerMenuProvider.profile? secondary : Colors.black ,
                          textStyle: black20,
                          boxHeight: 50,
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      trainerMenuProvider.onClickSideMenu(2);
                      onMenuItemSelected(TrainerMenuItem.batch);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        //decoration: box12Sidebar,
                        child: TextLiquidFill(
                          text: 'Batch',
                          waveColor: trainerMenuProvider.batch? Colors.white : sweetYellow,
                          boxBackgroundColor: trainerMenuProvider.batch? secondary : Colors.black ,
                          textStyle: black20,
                          boxHeight: 50,
                        ),
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: (){
                      trainerMenuProvider.onClickSideMenu(1);
                      trainerMenuProvider.saveRoleToLocalStorage("");
                      trainerMenuProvider.saveTokenToLocalStorage("");
                      Navigator.pushReplacementNamed(context, "/");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: TextLiquidFill(
                          text: 'Logout',
                          waveColor: trainerMenuProvider.logout? Colors.white : sweetYellow,
                          boxBackgroundColor: trainerMenuProvider.logout? secondary : Colors.black ,
                          textStyle: black20,
                          boxHeight: 50,
                          waveDuration: Duration(seconds: 90),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

