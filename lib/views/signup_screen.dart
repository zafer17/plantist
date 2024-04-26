
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:plantist/controllers/auth_controllers.dart';
import 'package:plantist/views/home_screen.dart';
import 'package:plantist/views/widgets/text_input.dart';
import '../constant.dart';
import 'login_screen.dart';
class SignupScreen extends GetWidget<AuthController> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign up with email",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              "Enter your email and password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 25,
            ),


            const SizedBox(
              height: 15,
            ),

            //<------------------- text fields ------------------->
            Container(
              width: MediaQuery.of(context).size.width,
              margin: kIsWeb
                  ? const EdgeInsets.symmetric(horizontal: 350)
                  : const EdgeInsets.symmetric(horizontal: 25),
              child: TextInputField(
                hintText: "E-mail",
                controller: emailController,
                labelText: "Enter Email",
                icon: Icons.email,
              ),


            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: kIsWeb
                  ? const EdgeInsets.symmetric(horizontal: 350)
                  : const EdgeInsets.symmetric(horizontal: 25),
              child: TextInputField(
                hintText: "Password",
                controller: passwordController,
                labelText: "Enter Password",
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //<------------------- sign up button ------------------->
            Container(
              width: MediaQuery.of(context).size.width,
              margin: kIsWeb
                  ? const EdgeInsets.symmetric(horizontal: 350)
                  : const EdgeInsets.symmetric(horizontal: 25),
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: InkWell(

                onTap: () async {
                  String res = await controller.registerUser(
                      emailController.text,
                      passwordController.text
                  );

                  //redirect to login if sign up is successful
                  if (res == "success") {

                        Get.offAll(() => Home());
                  }
                  else{
                    print("slkşdjflkşsajdflşkasjdflkşsda");
                  }
                },
                child: const Text("Create Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15)),
              ),
            ),
            const SizedBox(height: 18),

            //<------------------- login text row ------------------->
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("By continuing, you agree to our ",
                        style: TextStyle(fontSize: 12,color: Colors.black)),
                    InkWell(
                      onTap: () {

                      },
                      child: const Text(" Privacy Policy ",
                          style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                    ),
                    const Text("and",
                        style: TextStyle(fontSize: 12)),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: const Text("Terms of Use",
                          style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child: const Text("Dou you have already Account",
                          style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                    ),

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}