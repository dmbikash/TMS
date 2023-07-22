import 'package:flutter/material.dart';
import 'package:training_management_system/components/screen_size.dart';

import 'box_decorations.dart';


class CardsOfBatchInfo {

  Padding cards(BuildContext context,String title, String subtitle ){
    return  Padding(

      padding: const EdgeInsets.fromLTRB(0, 0, 10, 8),
      child: Container(
        width: width(context)* 0.18,
        height: height(context)*0.25,
        decoration: box12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Navigate to corresponding page on button press
              },
              child: Text('Go to $title'),
            ),
          ],
        ),
      ),
    );
  }
}

