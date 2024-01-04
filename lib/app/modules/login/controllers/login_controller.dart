import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketsosialmedia/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final Rxn<int> rememberMe = Rxn<int>();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    usernameCtrl.text = 'adiyoga27';
    passwordCtrl.text = 'bogis1996';
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSubmit() {
    print('sadasdasdasdasdsa');
    print("username ${usernameCtrl.text}");
    if (usernameCtrl.text == 'adiyoga27' && passwordCtrl.text == 'bogis1996') {
      Get.toNamed(Routes.DASHBOARD);
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Login Failed',
          message: 'Username or Password not found !',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
