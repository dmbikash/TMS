import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_management_system/provider/admin_batch_info_provider.dart';
import 'package:training_management_system/provider/admin_dashboard_provider.dart';
import 'package:training_management_system/provider/create_user_provider.dart';
import 'package:training_management_system/provider/login_provider.dart';
import 'package:training_management_system/provider/trainee_dashboard_provider.dart';
import 'package:training_management_system/provider/trainer_dashboard_provider.dart';
import 'package:training_management_system/screen/course/admin_batch_info.dart';
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


      },
    );
  }
}

