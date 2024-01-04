import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketsosialmedia/app/models/profile_model.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  final count = 0.obs;
  RxBool isLoading = true.obs;
  late ProfileModel profileModel;
  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future onRefresh() async {
    isLoading.value = true;
    var url = Uri.https('buzzerpanel.id', 'api/json.php');
    var response = await http.post(url, body: {
      'api_key': '12ucva9651gfwec083fxz21d5b7pjmli',
      'secret_key': 'j3s2pxic1wbln8sgbqth42rejxagzrfw9a3dlqvo8cku70y0pi',
      'action': 'profile'
    });
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {
        profileModel = ProfileModel.fromJson(responseBody['data']);
      } else {
        // Handle error or invalid response
        print('Error: ${response.body}');
      }
    } else {
      // Handle other HTTP response codes
      print('Error: ${response.body}');
    }
    isLoading.value = false;
    update();
  }

  void increment() => count.value++;
}
