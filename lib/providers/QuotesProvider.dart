import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quotes_admin_app/models/Category.dart';
import 'package:quotes_admin_app/models/Quote.dart';
import 'package:quotes_admin_app/utils/config.dart';
import 'package:quotes_admin_app/utils/funcs.dart';
import 'package:smart_select/smart_select.dart';

class QuotesProvider extends ChangeNotifier {
  List<String> tags = List();
  String text;
  String category_id;
  List<S2Choice<String>> categories = [];
  List<Quote> quotes;

  Category category;

  int from = 0;

  void addTag(String value) {
    if (!tags.contains(value)) {
      tags.add(value);
      notifyListeners();
    }
  }

  getCategories() async {
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
                : S2Choice(
                    title: Category.fromJson(e as Map<String, dynamic>).name,
                    value: Category.fromJson(e as Map<String, dynamic>).id))
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

  removeTag(value) {
    tags.remove(value);
    notifyListeners();
  }

  clearTags() {
    tags.clear();
    notifyListeners();
  }

  add() async {
    try {

      if(text == null || text.isEmpty){
        EasyLoading.showError("ادخل النص");
        return;
      }

      if(category_id == null || category_id.isEmpty){
        EasyLoading.showError("اختار القسم");
        return;
      }


      String token = await funcs().getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("لا يوجد رمز امان مسجل");
        return;
      }
      Response response = await Dio().post(
          Config.ADMIN_URL + "/quotes/add?admin-api-token=" + token,
          data: {"text": text, "category_id": category_id, "tags": tags});
      if (response.data["success"] == true) {
        EasyLoading.showSuccess("تم الاضافه بنجاح");
        return true;
      }
    } catch (e) {
      print(e.message);
    }
  }

  void reset() {
    text = null;
    //category_id = null;
    tags.clear();
    notifyListeners();
  }

  Future<void> getAll() async {
    String token = await funcs().getToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
      return;
    }

    try {
      Response response = await Dio().get(
          Config.ADMIN_URL + "/quotes/get/all/$from?admin-api-token=$token");

      if (response.data["success"] == true) {
        quotes = (response.data["data"]["quotes"] as List)
            ?.map((e) =>
                e == null ? null : Quote.fromJson(e as Map<String, dynamic>))
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

  remove(id) async {
    String token = await funcs().getToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
      return;
    }

    try {
      Response response = await Dio().get(
          Config.ADMIN_URL + "/quotes/remove/$id?admin-api-token=$token");

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

  Future<void> getCategory(context, id) async {
    try {
      /*
      if (!await checkInternet()) {
        EasyLoading.showError("لا يوجد انترنت");
        isError = true;
        notifyListeners();
        return;
      }
       */

      String token = await funcs().getToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("لا يوجد رمز امان .. الرجاء تسجيل الدخول");
        return;
      }

      Response response =
      await Dio().get(Config.ADMIN_URL + "/quotes/get/category/$id/$from?admin-api-token=$token");

      if (response.data["success"] == true) {
        if (from == 0) {
          category = Category.fromJson(response.data["data"]["category"]);
        }

        if (category != null) {
          if (category.quotes != null && from != 0) {
            category.quotes.addAll((response.data["data"]["quotes"] as List)
                ?.map((e) => e == null
                ? null
                : Quote.fromJson(e as Map<String, dynamic>))
                ?.toList());
          } else {
            category.quotes = (response.data["data"]["quotes"] as List)
                ?.map((e) => e == null
                ? null
                : Quote.fromJson(e as Map<String, dynamic>))
                ?.toList();

            /*
            if(category.quotes != null && category.quotes.isNotEmpty){
              for(int i = 1; i <= adsCount ;i++){
                int index = (i*7-6) < category.quotes.length ?(i*7-6) : category.quotes.length;
                category.quotes.insert(index, Quote(isAd: true));
              }
            }
             */

          }

          //isError = false;
        } else {
          //isError = true;
          EasyLoading.showError("حدث خطأ ما !");
        }
      } else {
        //isError = true;
        EasyLoading.showError("خطأ من السيرفر\n كود الخطأ : " +
            response.data['err']['code']?.toString());
      }

    } catch (e) {
      //isError = true;
      //catchError(context, e);
    }

    notifyListeners();
  }

}
