import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_flutter_project_admin/views/pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/authentication_controller.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Authentication());
  final prefs = await SharedPreferences.getInstance();
  runApp(GetMaterialApp(
      title: "Vehicle Rent",                            
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      
    
  ));
}