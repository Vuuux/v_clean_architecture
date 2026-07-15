import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/app/main_app.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = GlobalHttpOverrides(
    globalHeaders: {HttpConstants.xAppId: AppEnvironment.xAppId},
  );
  // await Firebase.initializeApp(
  //   options: AppEnvironment.env == 'prd'
  //       ? AppFirebaseOptions.prod
  //       : AppFirebaseOptions.nonProd,
  // );
  runApp(const MainApp());
}
