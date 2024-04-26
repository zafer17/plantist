import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:plantist/controllers/auth_controllers.dart';
import 'package:plantist/views/signup_screen.dart';
import 'package:plantist/views/widgets/text_input.dart';
import '../constant.dart';


class LoginScreen extends GetWidget<AuthController> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Application",
              style: TextStyle(
                  color: buttonColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            ),
            const Text(
              "Sign in with email",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const Text(
              "Enter your  email and password",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 25,
            ),

            //<------------------- text fields ------------------->
            Container(
              width: MediaQuery.of(context).size.width,
              margin: kIsWeb
                  ? const EdgeInsets.symmetric(horizontal: 350)
                  : const EdgeInsets.symmetric(horizontal: 25),
              child: TextInputField(
                hintText: "E-mail",
                controller: _emailController,
                labelText: "Enter email",
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: kIsWeb
                  ? const EdgeInsets.symmetric(horizontal: 350)
                  : const EdgeInsets.symmetric(horizontal: 25),
              child: TextInputField(
                hintText: "Password",
                controller: _passwordController,
                labelText: "Enter Password",
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            //<------------------- Login button ------------------->
            Container(
              width: MediaQuery.of(context).size.width,
              margin: kIsWeb
                  ? const EdgeInsets.symmetric(horizontal: 350)
                  : const EdgeInsets.symmetric(horizontal: 25),
              height: 55,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: InkWell(
                onTap: () => controller.loginUser(
                    _emailController.text, _passwordController.text),
                child: const Text("Sign In ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
              ),
            ),
            const SizedBox(height: 18),

            //<------------------- sign up text row ------------------->
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont Have Account ",
                        style: TextStyle(fontSize: 12,color: Colors.black)),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => SignupScreen());
                      },
                      child: const Text("Create Accunt ",
                          style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                    ),
                    const Text("and Use it !!",
                        style: TextStyle(fontSize: 12)),


                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}