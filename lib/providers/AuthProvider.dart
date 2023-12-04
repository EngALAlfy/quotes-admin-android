import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quotes_admin_app/screens/HomeScreen.dart';
import 'package:quotes_admin_app/screens/LoginScreen.dart';
import 'package:quotes_admin_app/utils/config.dart';
import 'package:quotes_admin_app/utils/funcs.dart';

class AuthProvider extends ChangeNotifier {
  String username;
  String password;

  String token;

  bool isAuth = false;
  bool isLoad = false;

  checkLogin(context) async {
    String token = await funcs().getToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
      isAuth = false;
    } else {
      this.token = token;
      await checkToken();
    }

    isLoad = true;
    notifyListeners();
  }

  checkToken() async {
    try {
      Response response = await Dio().post(
          Config.ADMIN_URL + "/admins/check/token?admin-api-token=$token",
          data: {'token': token});

      if (response.data["success"] == true) {
        isAuth = true;
      } else {
        isAuth = false;
      }
    } catch (e) {
      print(e);
      isAuth = false;
    }
  }

  login(context) async {
    EasyLoading.show(status: "جار تسجيل الدخول ..");
    if (username == null || username.isEmpty) {
      EasyLoading.showError("الرجاء ادخال اسم المستخدم");
      return;
    }

    if (password == null || password.isEmpty) {
      EasyLoading.showError("الرجاء ادخال كلمة السر");
      return;
    }

    try {
      Response response = await Dio().post(Config.ADMIN_URL + "/admins/login",
          data: {'username': username, 'password': password});

      if (response.data["success"] == true) {
        String token = response.data["data"]["admin"]["token"];
        bool tokenSaved = await funcs().setToken(token);
        if (tokenSaved) {
          EasyLoading.showSuccess("تم تسجيل الدخول بنجاح");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          EasyLoading.showError("خطأ اثناء حفظ رمز الامان");
          return;
        }
      } else {
        EasyLoading.showError("خطأ من السيرفر\n كود الخطأ : " +
            response.data['err']['code']?.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  logout(context) async {
    await funcs().setToken(null);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
