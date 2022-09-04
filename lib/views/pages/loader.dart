import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_flutter_project_admin/utils/shared_prefs.dart';

import 'home_page.dart';
import 'login_page.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkifAuthenticated();
  }

  checkifAuthenticated() async {
    //wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    var token = await authService.getToken();
    if (token != null) {
      Get.offAll(const MyHomePage());
    } else {
      Get.offAll(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: 200,
              width: 200,
            ),
          ),
          const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}