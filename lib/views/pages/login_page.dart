import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_first_flutter_project_admin/views/pages/signup_page.dart';


import '../../controller/authentication_controller.dart';
import '../../utils/shared_prefs.dart';
import '../components/my_button.dart';
import '../components/my_field.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key : key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authentication = Get.find<Authentication>();
  final AuthService authService = AuthService();

  void initState(){
    super.initState();
    checkifAuthenticated();
  }
  checkifAuthenticated() async {
    var token = await authService.getToken();
    if (token != null){
      Get.offAll(const MyHomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 200,
                      width: 200,
                    ),
                    
                    MyField(
                      controller: emailController,
                      myValidator: (value) {
                        if (!value.toString().contains("@")) {
                          return "Email is not valid";
                        }
                        return null;
                      },
                    ),
                    MyField(
                      text: "Password",
                      obscureText: true,
                      controller: passwordController,
                      myValidator: (value) {
                        return null;
                      },
                    ),
                    MyButton(onTap: () {
                      var isFormValid = formKey.currentState!.validate();
                      if (isFormValid) {
                        var data = {
                          "email": emailController.text,
                          "password": passwordController.text
                        };
                        authentication.login(data);
                      }
                      },
                      text: 'Login',),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Forgot Password?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                    ),
                    SizedBox(height: 220,),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Don't have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(HomeScreen());
                      },
                      child: const Text("Register",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}