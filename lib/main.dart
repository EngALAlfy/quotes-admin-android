import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/AdminsProvider.dart';
import 'package:quotes_admin_app/providers/AuthProvider.dart';
import 'package:quotes_admin_app/providers/CategoriesProvider.dart';
import 'package:quotes_admin_app/providers/InfoProvider.dart';
import 'package:quotes_admin_app/providers/UtilsProvider.dart';
import 'package:quotes_admin_app/providers/QuotesProvider.dart';
import 'package:quotes_admin_app/providers/UsersProvider.dart';
import 'package:quotes_admin_app/screens/HomeScreen.dart';
import 'package:quotes_admin_app/screens/IntroScreen.dart';
import 'package:quotes_admin_app/screens/LoginScreen.dart';
import 'package:quotes_admin_app/utils/config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UtilsProvider()),
        ChangeNotifierProvider(create: (context) => QuotesProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => InfoProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => AdminsProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('ar', ''),
        ],
        theme: ThemeData(
          primarySwatch: Config.COLOR_SWATCH,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: EasyLoading.init(),
        home: Consumer2<UtilsProvider, AuthProvider>(
          builder: (context, utils, auth, child) {
            if (utils.noInternet) {
              EasyLoading.show(
                status: 'لا يوجد انترنت',
                maskType: EasyLoadingMaskType.black,
                dismissOnTap: false,
              );
              utils.internetDialogShow = true;
            } else {
              if (EasyLoading.isShow && utils.internetDialogShow) {
                EasyLoading.dismiss(animation: true);
                EasyLoading.showSuccess("تم استعادة الاتصال");
                utils.internetDialogShow = false;
              }
            }

            if (utils.isLoaded) {
              if (utils.isFirstOpen) {
                return IntroScreen();
              }

              if (auth.isLoad) {
                if (auth.isAuth) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              } else {
                auth.checkLogin(context);
              }
            }

            return child;
          },
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
