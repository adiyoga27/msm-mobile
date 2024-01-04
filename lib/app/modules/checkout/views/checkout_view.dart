import 'dart:convert';
import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:marketsosialmedia/app/core/theme/app_theme.dart';
import 'package:marketsosialmedia/app/models/service_model.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckoutView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? SizedBox(
              height: 10.0,
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori',
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DropdownSearch<ServiceModel>(
                      dropdownBuilder: (context, selectedItem) =>
                          Text(controller.categorySelected.category ?? ''),
                      popupProps: PopupProps.bottomSheet(),
                      asyncItems: (String filter) => controller.getData(filter),
                      itemAsString: (ServiceModel u) => u.category!,
                      onChanged: (ServiceModel? data) {
                        controller.categorySelected = data!;
                        controller.isLoading.value = false;
                        controller.getService();
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Service',
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DropdownSearch<ServiceModel>(
                      dropdownBuilder: (context, selectedItem) =>
                          Text(controller.serviceSelected.name ?? ''),
                      popupProps: PopupProps.bottomSheet(),
                      asyncItems: (String filter) => controller.getService(),
                      itemAsString: (ServiceModel u) => u.name!,
                      onChanged: (ServiceModel? data) {
                        controller.serviceSelected = data!;
                        controller.priceCtrl.text = "Rp. ${data.price!}";
                        controller.noteCtrl.text = data.note!;
                        controller.isLoading.value = false;
                        controller.getService();
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Price/K',
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 15, bottom: 8, top: 8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xC6C6C6))),
                        ),
                        controller: controller.priceCtrl,
                        style: GoogleFonts.manrope(
                          textStyle:
                              TextStyle(fontSize: 12.0, color: Colors.black),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Note',
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        readOnly: true,
                        controller: controller.noteCtrl,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 15, bottom: 8, top: 8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xC6C6C6))),
                        ),
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.manrope(
                          textStyle:
                              TextStyle(fontSize: 12.0, color: Colors.black),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'MIN: ${controller.serviceSelected.min}, MAKS:  ${controller.serviceSelected.max}',
                      style: GoogleFonts.manrope(
                          textStyle:
                              TextStyle(fontSize: 12.0, color: Colors.red)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Target/Link',
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: controller.targetCtrl,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 8, top: 8),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xC6C6C6))),
                        hintText: 'Input your link',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Jumlah',
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (value) => controller.calculate(value),
                      controller: controller.amountCtrl,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 8, top: 8),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xC6C6C6))),
                        hintText: 'Jumlah',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'Rp ${controller.subtotal}',
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w900,
                                color: primaryColor)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.onSubmit();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xAA351A96),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: Text(
                          'Checkout',
                          style: GoogleFonts.manrope(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
    );
  }
}
