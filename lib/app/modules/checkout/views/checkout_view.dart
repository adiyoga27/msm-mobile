import 'dart:convert';
import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:marketsosialmedia/app/core/theme/app_theme.dart';
import 'package:marketsosialmedia/app/models/service_model.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    return Wrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          centerTitle: true,
        ),
        body: LzFormList(
          style: LzFormStyle(activeColor: LzColors.black),
          children: [
            LzFormGroup(
              label: 'Services',
              prefixIcon: La.userCheck,
              children: [
                ...List.generate(2, (i) {
                  List<String> keys = ['Kategori', 'Layanan'];
                  return LzForm.select(
                      expandValue: true,
                      label: '${keys[i].ucwords} *',
                      hint: 'Pilih ${keys[i]}',
                      model: forms[keys[i]],
                      onTap: controller.onTap,
                      onSelect: controller.onSelect);
                }),
                LzForm.input(
                  maxLines: 6,
                  disabled: true,
                  model: forms['Deskripsi'],
                  label: 'Deskripsi',
                ),
                LzForm.input(
                  disabled: true,
                  model: forms['Limit'],
                  label: 'Limit',
                ),
                LzForm.input(
                  disabled: true,
                  model: forms['Harga'],
                  label: 'Harga',
                  hint: 'Harga Layanan',
                ),
              ],
            ),
            LzFormGroup(
              label: 'Pesanan',
              prefixIcon: La.userCheck,
              children: [
                LzForm.input(
                  keyboard: TextInputType.text,
                  hint: 'Masukkan Link / Username Target',
                  model: forms['Target'],
                ),
                LzForm.input(
                  keyboard: TextInputType.number,
                  model: forms['Jumlah'],
                  onChange: (value) => controller.subtotal.value =
                      (double.parse("${controller.serviceModel.price}") *
                              double.parse(value)) /
                          1000,
                  hint: 'Masukkan jumlah pembelian',
                ),
                // LzForm.input(
                //   keyboard: TextInputType.number,
                //   model: forms['Nominal'],
                //   suffix: const LzInputicon(icon: Icons.currency_bitcoin),
                //   hint: 'Masukkan jumlah pembayaran',
                // ),
              ],
            ),
            const LzTextDivider(Text(
              'Total Pembelian',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            Obx(() => Textr(
                '${controller.subtotal}'
                    .currency(symbol: 'Rp', decimalDigits: 0, separator: '.'),
                style: const TextStyle(fontSize: 23.0),
                textAlign: Ta.center,
                padding: Ei.all(15))),
          ],
        ),
        bottomNavigationBar: LzButton(
          text: 'Checkout',
          onTap: (state) async {
            state.submit();
            await controller.onSubmit();
            state.abort();
          },
        ).dark().style(LzButtonStyle.shadow, spacing: 20),
      ),
    );
  }
}
