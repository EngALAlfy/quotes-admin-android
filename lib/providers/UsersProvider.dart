import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quotes_admin_app/utils/config.dart';
import 'package:quotes_admin_app/utils/funcs.dart';

class UsersProvider extends ChangeNotifier{

  var statistics;

  getStatistics() async {
    String token = await funcs().getToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
      return;
    }

    try {
      Response response = await Dio().get(
          Config.ADMIN_URL + "/users/get/statistics?admin-api-token=" + token);

      if (response.data["success"] == true) {
        print(response.data);
        statistics = response.data["data"];
        notifyListeners();
      } else {
        EasyLoading.showError("خطأ من السيرفر\n كود الخطأ : " +
            response.data['err']['code']?.toString());
      }
    } catch (e) {
      print(e);
    }
  }

}