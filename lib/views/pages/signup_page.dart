import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../controller/authentication_controller.dart';
import '../../utils/constants.dart';
import '../../utils/shared_prefs.dart';
import '../components/my_button.dart';
import '../components/my_field.dart';
import 'login_page.dart';

class HomeScreen extends StatelessWidget {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authentication = Get.find<Authentication>();
  final authService = AuthService();
  HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  Image.asset("assets/images/logo.png",
                  height: 200,
                  width: 200,
                  ),
                  Text ("Create a new account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(255, 31, 201, 213), 
                  ),
                ),
                  MyField(
                    text: "Full Name",
                    controller: fullNameController,
                    myValidator: (value){
                      return null;
                    },
                  ),
              
                  MyField(
                    controller: emailController,
                    myValidator: (value){
                      if (!value.toString().contains("@")){
                        return "Email is not valid";
                      }
                      return null;
                    },
                  ),
                  MyField(
                    text: "Address",
                    controller: addressController,
                    myValidator: (value){
                      return null;
                    },
                  ),
                  MyField(
                    text: "Phone No.",
                    controller: phoneController,
                    myValidator: (value){
                      return null;
                    },
                  ),
                  MyField(
                    text: "Password",
                    obscureText: true,
                    controller: passwordController,
                    myValidator: (value){
                      return null;
                    },
                  ),
                  MyField(
                    text: "Confirm Password",
                    obscureText: true,
                    controller: confirmPasswordController,
                  ),
                  
                  MyButton(onTap: (){
                    var isFormValid = formKey.currentState!.validate();
                    if(passwordController.text == confirmPasswordController.text){
                    if (isFormValid){
                      var data = {
                        "fullName": fullNameController.text,
                        "email": emailController.text,
                        "address": addressController.text,
                        "phone": phoneController.text,
                        "password": passwordController.text,
                    };
                   authentication.SignUp(data);
                   Get.to(LoginPage());
                    }
                  }else{
                    showMessage(
                      message: "Incorrect Password",
                      isSuccess: false);
                  }},
                  text: 'SignUp',),
                 
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Already have an account?"),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(LoginPage());
                      },
                      child: const Text("Login",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
            )],  
              ),
          ),
        ),),
    ));
  }
}