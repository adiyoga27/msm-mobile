import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:marketsosialmedia/app/models/service_model.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController
  final forms = LzForm.make([
    'Kategori',
    'Layanan',
    'Deskripsi',
    'Harga',
    'Jumlah',
    'Target',
    'Limit'
  ]);

  String? categoryId, serviceId;
  List<Option> categories = [];
  Map<String, List<Option>> services = {};

  ServiceModel categoryModel = ServiceModel();
  ServiceModel serviceModel = ServiceModel();
  RxDouble subtotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
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

  Future<List<ServiceModel>> getCategory() async {
    var response =
        await http.get(Uri.parse("https://marketsosialmedia.com/api/category"));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'] ?? [];
      List<ServiceModel> categoryModel = [
        ...data.map((e) => ServiceModel.fromJson(e))
      ];
      return categoryModel;
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  }

  Future<List<ServiceModel>> getServices(categoryId) async {
    var response = await http.get(
        Uri.parse("https://marketsosialmedia.com/api/services/$categoryId"));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'] ?? [];
      List<ServiceModel> serviceModel = [
        ...data.map((e) => ServiceModel.fromJson(e))
      ];
      return serviceModel;
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  }

  Future<ServiceModel> getServiceSelected(serviceId) async {
    var response = await http.get(Uri.parse(
        "https://marketsosialmedia.com/api/service-detail/$serviceId"));
    if (response.statusCode == 200) {
      return ServiceModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  }

  Future onTap(SelectController control) async {
    try {
      switch (control.label) {
        case 'Kategori':
          if (categories.isEmpty) {
            LzToast.overlay('Memuat data kategori...');
            final list = await getCategory();
            categories = list
                .map((e) => Option(option: e.category!, value: "${e.id}"))
                .toList();
          }
          control.options = categories;
          break;
        case 'Layanan':
          if (categoryId == null) {
            LzToast.show('Anda belum memilih provinsi.');
            return false;
          }
          if (services[categoryId] == null) {
            LzToast.overlay('Memuat data services...');
            final list = await getServices(categoryId);
            List<Option> options = list
                .map((e) => Option(option: e.name!, value: "${e.id}"))
                .toList();
            services = {...services, categoryId!: options};
          }
          control.options = services[categoryId]!;
          break;
        default:
      }
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  Future onSelect(SelectController control) async {
    try {
      switch (control.label) {
        case 'Kategori':
          categoryId = control.option?.value;
          serviceId = null;
          LzForm.reset(forms, only: [
            'Layanan',
            'Harga',
            'Deskripsi',
            'Jumlah',
            'Target',
            'Limit'
          ]);
          break;
        case 'Layanan':
          if (categoryId == null)
            return LzToast.show('Anda belum memilih Kategori.');

          serviceId = control.option?.value;
          serviceModel = await getServiceSelected(serviceId);

          print(serviceModel.price);

          forms['Harga']?.controller.text = serviceModel.price
              .currency(symbol: "Rp", decimalDigits: 0, separator: '.');
          forms['Deskripsi']?.controller.text = "${serviceModel.note}";
          forms['Limit']?.controller.text =
              "min: ${serviceModel.min}, max:${serviceModel.min}";
          update();
          break;
        default:
      }
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  Future onSubmit() async {
    final form = LzForm.validate(
      forms,
      required: ['*'],
      messages: FormMessages(required: {
        'Kategori': 'Kategori tidak boleh kosong',
      }),
    );
    final payload = {...form.value};

    try {
      var response = await http.post(
        Uri.parse("https://marketsosialmedia.com/api/checkout"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'service': serviceId!,
          'quantity': payload['Jumlah'],
          'target': payload['Target'],
        }),
      );
      Get.closeAllSnackbars();
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status']) {
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
        throw Exception("Error ${response.statusCode}");
      }
      return true;
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
