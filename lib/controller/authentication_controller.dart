import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_first_flutter_project_admin/utils/api.dart';



import '../utils/constants.dart';
import '../utils/shared_prefs.dart';
import '../views/pages/home_page.dart';
import '../views/pages/loader.dart';
import '../views/pages/login_page.dart';

class Authentication extends GetxController {
  final _token = ''.obs;
  final authService = AuthService();


  login(data) async {
    print(data);
    var url = Uri.parse(LOGIN_API);
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        await authService.saveToken(jsonResponse["token"]);
        Get.offAll(const MyHomePage());
        Get.snackbar(
          "Success",
          jsonResponse["message"],
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          "Error",
          jsonResponse["message"],
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  SignUp(data) async {
    var url = Uri.parse(SIGNUP_API);
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        Get.offAll(const LoginPage());
        showMessage(message: jsonResponse["message"], isSuccess: true);
      } else {
        showMessage(message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  logout() async {
    var url = Uri.parse(LOGOUT_API);
    var token_ = await authService.getToken();
    var response = await http.post(url, body: {"token": token_});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["success"]) {
        await authService.removeToken();
        Get.offAll(const Loader());
        showMessage(message: jsonResponse["message"], isSuccess: true);
      } else {
        showMessage(message: jsonResponse["message"], isSuccess: false);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}