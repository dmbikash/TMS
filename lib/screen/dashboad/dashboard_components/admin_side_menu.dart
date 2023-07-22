import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../components/box_decorations.dart';
import '../../../components/color.dart';
import '../../../components/screen_size.dart';
import '../../../components/text_style.dart';

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Container(
        height: height(context) * .80,
        decoration: box12Sidebar,
        //color: Colors.orangeAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //decoration: box12Sidebar,
                  child: TextLiquidFill(
                    text: 'Profile',
                    waveColor: sweetYellow,
                    boxBackgroundColor: Colors.black,
                    textStyle: black20,
                    boxHeight: 70,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //decoration: box12Sidebar,
                  child: TextLiquidFill(
                    text: 'BATCH',
                    waveColor: sweetYellow,
                    boxBackgroundColor: Colors.black,
                    textStyle: black20,
                    boxHeight: 70,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, "TraineeRegister");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextLiquidFill(
                    text: 'CREATE ACCOUNT',
                    waveColor: sweetYellow,
                    boxBackgroundColor: Colors.black,
                    textStyle: black20,
                    boxHeight: 70,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextLiquidFill(
                    text: 'Logout',
                    waveColor: sweetYellow,
                    boxBackgroundColor: Colors.black,
                    textStyle: black20,
                    boxHeight: 70,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}