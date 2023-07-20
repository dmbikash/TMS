import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/admin/addTraineeToBatch_provider.dart';
import 'package:training_management_system/provider/admin/addTrainerToBatch_provider.dart';
import 'package:training_management_system/provider/admin/admin_batch_info_provider.dart';
import 'package:training_management_system/provider/admin/admin_dashboard_provider.dart';
import 'package:training_management_system/provider/admin/batch_details_provider.dart';
import 'package:training_management_system/provider/admin/course_info_provider.dart';
import 'package:training_management_system/provider/admin/create_user_provider.dart';
import 'package:training_management_system/provider/login_provider.dart';
import 'package:training_management_system/provider/trainee/trainee_dashboard_provider.dart';
import 'package:training_management_system/provider/trainer/trainer_dashboard_provider.dart';
import 'package:training_management_system/screen/batch/add_trainee_to_batch.dart';
import 'package:training_management_system/screen/batch/add_trainer_to_batch.dart';
import 'package:training_management_system/screen/batch/admin_batch_info.dart';
import 'package:training_management_system/screen/batch/batch_details.dart';
import 'package:training_management_system/screen/batch/course_info.dart';
import 'package:training_management_system/screen/dashboad/admin_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_management_system/screen/dashboad/trainee_dashboard.dart';
import 'package:training_management_system/screen/dashboad/trainer_dashboard.dart';
import 'package:training_management_system/screen/log_reg/login.dart';
import 'package:training_management_system/create_user/create_user.dart';

import 'create_user/admin_register.dart';

void main() {
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AdminDashboardProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => CreateUserProvider()),
      ChangeNotifierProvider(create: (_) => TrainerDashboardProvider()),
      ChangeNotifierProvider(create: (_) => TraineeDashboardProvider()),
      ChangeNotifierProvider(create: (_) => AdminBatchInfoProvider()),
      ChangeNotifierProvider(create: (_) => AddTrainerToBatchProvider()),
      ChangeNotifierProvider(create: (_) => AddTraineeToBatchProvider()),
      ChangeNotifierProvider(create: (_) => BatchDetailsProvider()),
      ChangeNotifierProvider(create: (_) => CourseInfoProvider()),


    ],
      child :MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),

        'TraineeRegister': (context) => CreateUser(),
        'AdminRegister': (context) => AdminRegister(),

        'AdminDashboard': (context) => AdminDashboard(),
        'TraineeDashboard': (context) => TraineeDashboard(),
        'TrainerDashboard' : (context) => TrainerDashboard(),

        'AdminBatchInfo' : (context) => AdminBatchInfo(),
        'AddTrainerToBatch' : (context) => AddTrainerToBatch(),
        'AddTraineeToBatch' : (context) => AddTraineeToBatch(),

        'BatchDetails' : (context) => BatchDetails(),
        'CourseInfo' : (context) => CourseInfo(),


      },
    );
  }
}

