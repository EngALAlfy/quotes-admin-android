import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quotes_admin_app/models/Category.dart';
import 'package:quotes_admin_app/models/Quote.dart';
import 'package:quotes_admin_app/utils/config.dart';
import 'package:quotes_admin_app/utils/funcs.dart';

class CategoriesProvider extends ChangeNotifier{
  var name;

  Category category;

  List<Category> categories;


  getAll() async {
    String token = await funcs().getToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
      return;
    }

    try {
      Response response = await Dio().get(
          Config.ADMIN_URL + "/categories/get/all?admin-api-token=" + token);

      if (response.data["success"] == true) {
        categories = (response.data["data"]["categories"] as List)
            ?.map((e) => e == null
            ? null
            : Category.fromJson(e as Map<String, dynamic>))
            ?.toList();

        notifyListeners();
      } else {
        EasyLoading.showError("خطأ من السيرفر\n كود الخطأ : " +
            response.data['err']['code']?.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  add() async {
    try{
      String token = await funcs().getToken();
      if(token == null || token.isEmpty){
        EasyLoading.showError("لا يوجد رمز امان مسجل");
        return;
      }
      Response response = await Dio().post(Config.ADMIN_URL + "/categories/add?admin-api-token="+token , data: {"name":name});
      if(response.data["success"] == true){
        EasyLoading.showSuccess("تم الاضافه بنجاح");
      }
    }catch(e){
      print(e);
    }
  }

  get(id) async {
    String token = await funcs().getToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
      return;
    }

    try {
      Response response = await Dio().get(
          Config.ADMIN_URL + "/categories/get/$id?admin-api-token=" + token);

      if (response.data["success"] == true) {
        category = Category.fromJson(response.data["data"]["category"]);

        notifyListeners();
      } else {
        EasyLoading.showError("خطأ من السيرفر\n كود الخطأ : " +
            response.data['err']['code']?.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  update(){

  }

  remove(id) async {
    String token = await funcs().getToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
      return;
    }

    try {
      Response response = await Dio().get(
          Config.ADMIN_URL + "/categories/remove/$id?admin-api-token=$token");

      if (response.data["success"] == true) {
        EasyLoading.showSuccess("تم الحذف بنجاح");
        getAll();
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