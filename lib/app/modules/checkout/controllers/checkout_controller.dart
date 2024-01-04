import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketsosialmedia/app/models/service_model.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController

  List<ServiceModel> serviceModel = [], categoryModel = [];
  ServiceModel categorySelected = ServiceModel();
  ServiceModel serviceSelected = ServiceModel();
  TextEditingController targetCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  RxDouble subtotal = 0.0.obs;
  final count = 0.obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    getData('adasd');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {}

  Future<List<ServiceModel>> getData(String filter,
      {String storeId = ""}) async {
    isLoading.value = true;
    var response =
        await http.get(Uri.parse("https://marketsosialmedia.com/api/category"));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'] ?? [];

      isLoading.value = false;
      categoryModel = [...data.map((e) => ServiceModel.fromJson(e))];
    } else {
      throw Exception("Error ${response.statusCode}");
    }
    isLoading.value = false;
    update();
    return categoryModel;
  }

  Future<List<ServiceModel>> getService() async {
    isLoading.value = true;
    var response = await http.get(Uri.parse(
        "https://marketsosialmedia.com/api/services/${categorySelected.id}"));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'] ?? [];
      print(data);
      isLoading.value = false;
      serviceModel = [...data.map((e) => ServiceModel.fromJson(e))];
    } else {
      throw Exception("Error ${response.statusCode}");
    }
    isLoading.value = false;
    update();
    return serviceModel;
  }

  void calculate(String amount) {
    subtotal.value =
        double.parse(serviceSelected.price!) / 1000 * double.parse(amount);
    update();
  }

  Future onSubmit() async {
    Get.showSnackbar(
      const GetSnackBar(
        showProgressIndicator: true,
        backgroundColor: Colors.yellow,
        title: 'Progress ... ',
        message: 'Mohon Menunggu',
        icon: Icon(Icons.lock_clock),
      ),
    );

    var response = await http.post(
      Uri.parse("https://marketsosialmedia.com/api/checkout"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'service': "${serviceSelected.id}",
        'quantity': amountCtrl.text,
        'target': targetCtrl.text,
      }),
    );
    Get.closeAllSnackbars();
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status']) {
        reset();
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.green,
            title: 'Success Checkout',
            message: 'Check your service',
            icon: Icon(Icons.check),
            duration: Duration(seconds: 5),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            title: 'Gagal Checkout',
            message: data['data']['msg'],
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } else {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          title: 'Gagal Checkout',
          message: '${response.statusCode} Check your service',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 5),
        ),
      );
      throw Exception("Error ${response.statusCode}");
    }
  }

  reset() {
    targetCtrl.text = "";
    amountCtrl.text = "";
    subtotal.value = 0.0;
  }
}
