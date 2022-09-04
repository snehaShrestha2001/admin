import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/authentication_controller.dart';


class TabOne extends StatelessWidget {
  final authentication = Get.find<Authentication>();
  TabOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 150, 218, 231),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () => logout(), child: const Text("Logout")),
          ],
        ),
      ),
    );
  }

  logout() async {
    await authentication.logout();
  }
}
