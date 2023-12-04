import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/AuthProvider.dart';
import 'package:quotes_admin_app/providers/UtilsProvider.dart';
import 'package:quotes_admin_app/screens/HomeScreen.dart';
import 'package:quotes_admin_app/screens/LoginScreen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          image: FlutterLogo(),
          title: "لوحة التحكم بتطبيقات رسالتي",
          body:
              "لادارة تطبيقات رسالتي واضافه الاقتباسات والاقسام ومتابعه التطبيقات",
          decoration: const PageDecoration(
            imageFlex: 2,
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            pageColor: Colors.red,
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          image: FlutterLogo(),
          title: "الصلاحيات",
          body: "قم باعطاء التطبيق الصلاحيات اللازمه لامكانية ادارة تطبيقاتك",
          decoration: const PageDecoration(
            imageFlex: 2,
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            pageColor: Colors.amber,
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          title: "استمتع",
          image: FlutterLogo(),
          body: "كل شيء علي ما يرام",
          decoration: const PageDecoration(
            imageFlex: 2,
            titleTextStyle:
                TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            pageColor: Colors.blue,
            imagePadding: EdgeInsets.zero,
          ),
        ),
      ],
      onDone: () async {
        UtilsProvider utilsProvider =
            Provider.of<UtilsProvider>(context, listen: false);
        bool permissions = await utilsProvider.setPermissions();
        if (permissions) {
          await utilsProvider.setFirstOpen();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        } else {
          EasyLoading.showError("لم يتم اعطاء الصلاحيات");
        }
      },
      done: const Text(
        "فهمت",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      showSkipButton: false,
      next: const Icon(Icons.navigate_next),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).accentColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
