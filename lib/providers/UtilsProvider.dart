import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsProvider extends ChangeNotifier {
  bool noInternet = false;
  bool isFirstOpen = true;
  bool isLoaded = false;

  bool internetDialogShow = false;

  UtilsProvider() {
    checkFirstOpen();
    checkInternet();
    addInternetListener();
  }

  checkFirstOpen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isFirstOpen = preferences.getBool("isFirstOpen")??true;
    isLoaded = true;
    notifyListeners();
  }

  setFirstOpen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isFirstOpen" , false);
    notifyListeners();
  }

  addInternetListener(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        noInternet = true;
      } else {
        noInternet = false;
      }

      notifyListeners();
    });
  }

  checkInternet() {
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        noInternet = true;
      } else {
        noInternet = false;
      }

      notifyListeners();
    });
  }

  setPermissions() async {
   return Permission.storage.request().isGranted;
  }

}
