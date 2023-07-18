import 'package:flutter/material.dart';
import 'package:training_management_system/components/color.dart';

class Drawyer extends StatelessWidget {
  const Drawyer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          // padding: EdgeInsets.zero,
          children: <Widget>[
            //SizedBox(height: 20,),
            // SizedBox(
            //   width: 200,
            //   height: 200,
            //   child: CircleAvatar(
            //     child: Image.asset("assets......",
            //       fit: BoxFit.cover,width: 150,
            //     ),
            //   ),
            // ),
            //SizedBox(height: 20,),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Center(
                    child: Text("T  M  S",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Divider(

                  ),
                ),

                ListTile(
                  title: Text('A'),
                  onTap: () {
                    // Handle menu item tap
                  },
                ),
                ListTile(
                  title: Text('B '),
                  onTap: () {
                    // Handle menu item tap
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                    color: yellow400,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextButton(
                  onPressed: () {  },
                    child: Text('LOGOUT',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),),

                ),
              ),
            ),

            // Add more menu items as needed
          ],
        ),
      ),
    );
  }
}