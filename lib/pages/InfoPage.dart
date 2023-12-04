import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/UsersProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<UsersProvider>(context , listen: false).getStatistics();

    return SingleChildScrollView(
      key: PageStorageKey<int>(1),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Card(
                  shadowColor: Colors.grey,
                  elevation: 5,
                  color: Colors.orangeAccent,
                  child: Container(
                    child: Column(
                      children: [
                        Consumer<UsersProvider>(builder: (context, value, child) {
                          if(value.statistics == null ){
                            return Center(child: CircularProgressIndicator(),);
                          }

                          return Text("${value.statistics["day"]} مستخدم ", style: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),);
                        },),
                        Divider(color:Colors.black),
                        Text("اخر ظهور في خلال 24 ساعه",style: TextStyle(color: Colors.white , fontSize: 13),),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                  ),
                ),),
                Expanded(child: Card(
                  shadowColor: Colors.grey,
                  elevation: 5,
                  color: Colors.blueAccent,
                  child: Container(
                    child: Column(
                      children: [
                        Consumer<UsersProvider>(builder: (context, value, child) {
                          if(value.statistics == null ){

                            return Center(child: CircularProgressIndicator(),);                          }

                          return Text("${value.statistics["week"]} مستخدم ", style: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),);
                        },),
                        Divider(color:Colors.black),
                        Text("اخر ظهور في خلال اسبوع",style: TextStyle(color: Colors.white , fontSize: 13),),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                  ),
                ),),
              ],
            ),
            Row(
              children: [
                Expanded(child: Card(
                  shadowColor: Colors.grey,
                  elevation: 5,
                  color: Colors.purpleAccent,
                  child: Container(
                    child: Column(
                      children: [
                        Consumer<UsersProvider>(builder: (context, value, child) {
                          if(value.statistics == null ){

                            return Center(child: CircularProgressIndicator(),);                          }

                          return Text("${value.statistics["month"]} مستخدم ", style: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),);
                        },),
                        Divider(color:Colors.black),
                        Text("اخر ظهر في خلال شهر",style: TextStyle(color: Colors.white , fontSize: 13),),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                  ),
                ),),
                Expanded(child: Card(
                  shadowColor: Colors.grey,
                  elevation: 5,
                  color: Colors.deepOrangeAccent,
                  child: Container(
                    child: Column(
                      children: [
                        Consumer<UsersProvider>(builder: (context, value, child) {
                          if(value.statistics == null ){

                            return Center(child: CircularProgressIndicator(),);                          }

                          return Text("${value.statistics["all"]} مستخدم ", style: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),);
                        },),
                        Divider(color:Colors.black),
                        Text("كل المستخدمين",style: TextStyle(color: Colors.white , fontSize: 13),),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                  ),
                ),),
              ],
            ),
            Divider(height: 40,),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () {
                  notificationDialog(context);
                },
                child: Text(
                  "ارسال اشعار",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {
                  sendFCM();
                },
                child: Text(
                  "ارسال اشعار بالمحتوي جديد",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendFCM(
      {title = "رسايل جديدة", body = "ضفنالك رسايل جديدة ادخل وشاركها"}) async {
    try {
      var serverToken =
          "AAAA9iY_-Ms:APA91bERRaqkiGCRVRrVE7Ds2d1xaMKCJfJCBXSCHSeGiXk9S_jhio14tOjJYeEb48iT3qzplEMVjHqDTApafNLc6021OD94PiEDINGNKzpu0d4llVJV5tapRqimq7l8HqSLNt1LWlgj";

      var options = Options(
        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          'Authorization': 'key=$serverToken',
        },
      );

      var data = jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': "بوستاتي : $title",
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to': '/topics/newTopic',
        },
      );

      Response response = await Dio().post(
          'https://fcm.googleapis.com/fcm/send',
          data: data,
          options: options);

      var result = response.data as Map<String, dynamic>;
      if (result.containsKey("message_id")) {
        EasyLoading.showSuccess("تم ارسال الاشعار");
      } else {
        print(response.data);
        EasyLoading.showError(response.data);
      }
    } catch (e) {
      print(e);
      EasyLoading.showError(e.toString());
    }
  }

  void notificationDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    Alert(
        context: context,
        title: "اشعار جديد",
        type: AlertType.success,
        content: Container(
          height: 200,
          width: 300,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "عنوان الاشعار",
                ),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                  labelText: "نص الاشعار",
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
              color: Colors.green,
              child: Text(
                "ارسال",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (titleController.text.isEmpty ||
                    bodyController.text.isEmpty) {
                  EasyLoading.showError("ادخل الاشعار");
                  return;
                }

                var title = titleController.text;
                var body = bodyController.text;
                sendFCM(title: title, body: body);
                Navigator.pop(context);
              })
        ]).show();
  }
}
