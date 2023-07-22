import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/BatchesOfTrainerProvider.dart';
import 'package:training_management_system/provider/addTraineeToBatch_provider.dart';
import 'package:training_management_system/provider/addTrainerToBatch_provider.dart';
import 'package:training_management_system/provider/admin_batch_info_provider.dart';
import 'package:training_management_system/provider/admin_dashboard_provider.dart';
import 'package:training_management_system/provider/alu_provider.dart';
import 'package:training_management_system/provider/assignment_trainer_provider.dart';
import 'package:training_management_system/provider/batch_details_provider.dart';
import 'package:training_management_system/provider/batch_info_trainer_provider.dart';
import 'package:training_management_system/provider/course_info_provider.dart';
import 'package:training_management_system/provider/course_info_trainer_provider.dart';
import 'package:training_management_system/provider/create_user_provider.dart';
import 'package:training_management_system/provider/login_provider.dart';
import 'package:training_management_system/provider/menu_provider.dart';
import 'package:training_management_system/provider/schedule_provider.dart';
import 'package:training_management_system/provider/trainee_dashboard_provider.dart';
import 'package:training_management_system/provider/trainer_dashboard_provider.dart';
import 'package:training_management_system/provider/trainer_menu_provider.dart';
import 'package:training_management_system/screen/batch/add_trainee_to_batch_old.dart';
import 'package:training_management_system/screen/batch/add_trainer_to_batch_old.dart';
import 'package:training_management_system/screen/batch/admin_batch_info.dart';
import 'package:training_management_system/screen/dashboad/admin_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_management_system/screen/dashboad/trainee_dashboard.dart';
import 'package:training_management_system/screen/dashboad/trainer_dashboard.dart';
import 'package:training_management_system/screen/log_reg/login.dart';
import 'package:training_management_system/create_user/create_user.dart';

import 'create_user/admin_register.dart';
import 'landing_screen/landing_screen.dart';
import 'landing_screen_trainer/landing_screen_trainer.dart';


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
      ChangeNotifierProvider(create: (_) => ALU_Provider()),
      ChangeNotifierProvider(create: (_) => BatchDetailsProvider()),
      ChangeNotifierProvider(create: (_) => CourseInfoProvider()),
      ChangeNotifierProvider(create: (_) => Menuprovider()),
      ChangeNotifierProvider(create: (_) => TrainerMenuProvider()),
      ChangeNotifierProvider(create: (_) => BatchesOfTrainerProvider()),
      ChangeNotifierProvider(create: (_) => AssignmentTrainerProvider()),
      ChangeNotifierProvider(create: (_) => BatchInfoTrainerProvider()),
      ChangeNotifierProvider(create: (_) => CourseInfoTrainerProvider()),
      ChangeNotifierProvider(create: (_) => ScheduleProvider()),


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
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),

        'AdminHome': (context) => LandingScreen(),
        'LandingScreenTrainer': (context) => LandingScreenTrainer(),

        'TraineeRegister': (context) => CreateUser(),
        'AdminRegister': (context) => AdminRegister(),

        'AdminDashboard': (context) => AdminDashboard(),
        'TraineeDashboard': (context) => TraineeDashboard(),
        'TrainerDashboard' : (context) => TrainerDashboard(),

        //'AdminBatchInfo' : (context) => AdminBatchInfo(),
        'AddTrainerToBatch' : (context) => AddTrainerToBatchOld(),
        'AddTraineeToBatch' : (context) => AddTraineeToBatchOld(),


      },
    );
  }
}

