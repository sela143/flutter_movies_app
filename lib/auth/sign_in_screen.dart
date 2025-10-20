import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/sign_in_controller.dart';
import 'package:movies_app/routes/app_route.dart';

class SignInScreen extends StatelessWidget {
  final controller = Get.put(SignInController());
  final themeCtl = Get.find<HomeController>();
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: themeCtl.isDarkMode ? Colors.black : Colors.white,
        body: _buildBody,
      ),
    );
  }

  get _buildBody {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animation/panda_eat_popcorn.json",
                ),
                Form(
                    key: controller.formKey,
                    child: Column(
                      spacing: 20,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: controller.emailCtl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter your email",
                          ),
                        ),
                        TextFormField(
                          controller: controller.passwordCtl,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.visibility_off),
                            hintText: "Enter your password",
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    child: Obx(() => controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    onPressed: () {
                      controller.signIn(controller.emailCtl.text,
                          controller.passwordCtl.text);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.offAllNamed(AppRoute.signUp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
