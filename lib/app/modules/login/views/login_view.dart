import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketsosialmedia/app/core/theme/app_theme.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 200.0,
                  height: 200.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Hi, Wecome Back! 👋',
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.w600)),
              ),
              Text(
                'Hello again, you’ve been missed!',
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xAA999EA1))),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Username',
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: primaryColor)),
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: controller.usernameCtrl,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15, bottom: 8, top: 8),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xC6C6C6))),
                  hintText: 'Please Enter Your Username',
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Password',
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: primaryColor)),
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: controller.passwordCtrl,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15, bottom: 8, top: 8),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xC6C6C6))),
                  hintText: 'Please Enter Your Password',
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                      value: controller.rememberMe.value == 1,
                      onChanged: (val) {
                        val ?? true
                            ? controller.rememberMe.value = 1
                            : controller.rememberMe.value = null;
                      })),
                  Text(
                    'Remember Me',
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: primaryColor)),
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 50.0,
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () => controller.onSubmit(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xAA351A96),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.manrope(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
