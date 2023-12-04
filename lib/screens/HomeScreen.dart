import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/pages/AddCategoryPage.dart';
import 'package:quotes_admin_app/pages/AddQuotePage.dart';
import 'package:quotes_admin_app/pages/CategoriesPage.dart';
import 'package:quotes_admin_app/pages/InfoPage.dart';
import 'package:quotes_admin_app/pages/QuotesPage.dart';
import 'package:quotes_admin_app/providers/AuthProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 60),
              child: Text(
                "#رسالتي",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Divider(),
                  ListTile(
                    title: Text("لوحة التحكم"),
                    leading: Icon(Icons.info),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("المستخدمين"),
                    leading: Icon(Icons.person_search),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("البروفايل"),
                    leading: Icon(Icons.person),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("تسجيل الخروج"),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      AuthProvider authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      authProvider.logout(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: const Text("لوحة التحكم"),
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      isScrollable: true,
                      tabs: [
                        const Tab(text: "معلومات"),
                        const Tab(text: "التطبيقات | الاقسام"),
                        const Tab(text: "الرسائل"),
                        const Tab(text: "اضافه رسالة"),
                        const Tab(text: "اضافه قسم"),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            InfoPage(),
            CategoriesPage(),
            QuotesPage(),
            AddQuotePage(),
            AddCategoryPage(),
          ]),
        ),
      ),
    );
  }
}
