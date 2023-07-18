import 'package:flutter/material.dart';
import 'package:training_management_system/components/color.dart';

BoxDecoration box12 =  BoxDecoration(
   //color: Colors.yellow[400]?.withOpacity(.65),
    gradient:  LinearGradient(
        colors: [
          Color(0xFFFFC947).withOpacity(.15),
          Color(0xFFFFC947).withOpacity(.45),
          Color(0xFFFFC947).withOpacity(.75),

         // Color(0xFFFFC947)
        ]

    ),
    border: Border.all(width: 2,color: Colors.black54.withOpacity(.15)),
    borderRadius: BorderRadius.all(Radius.circular(12)),
);

BoxDecoration box12Sidebar =  BoxDecoration(
// color: sweetYellow,
 //  gradient:  LinearGradient(
 //      colors: [
 //        Color(0xFFFFC947),
 //        Color(0xFFFFC947).withOpacity(.65),
 //        Color(0xFFFFC947).withOpacity(.15),
 //
 //
 //      ]
 //
 //  ),
  border: Border.all(width: 5,color: sweetYellow),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);


BoxDecoration box12orange =  BoxDecoration(
  color: Colors.yellow[400]?.withOpacity(.65),
  gradient: const LinearGradient(
      colors: [
        Colors.white,
        Colors.orangeAccent,
      ]

  ),
  border: Border.all(width: 2,color: Colors.black54.withOpacity(.15)),
  borderRadius: const BorderRadius.all(Radius.circular(12)),
);
