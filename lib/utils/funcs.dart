import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class funcs {
  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("token");
  }

  setToken(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("token" , token);
  }
}