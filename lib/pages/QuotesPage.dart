import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/QuotesProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuotesProvider quotesProvider =
        Provider.of<QuotesProvider>(context, listen: false);
    quotesProvider.getAll();

    return Consumer<QuotesProvider>(
        builder: (context, value, child) {
          if (value.quotes != null) {
            return ListView.separated(
              key: PageStorageKey<int>(3),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                thickness: 10,
              ),
              itemCount: value.quotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.copy),
                            onPressed: () {
                              FlutterClipboard.copy(
                                  value.quotes.elementAt(index).text ??
                                      "لا يوجد نص")
                                  .then((value) =>
                                  EasyLoading.showSuccess("تم النسخ"));
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "تحذير !",
                                  desc: "هل انت متأكد من الحذف ؟",
                                  buttons: [
                                    DialogButton(
                                        child: Text(
                                          "نعم , حذف",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          value.remove(
                                              value.quotes.elementAt(index).id);

                                          Navigator.pop(context);
                                        }),
                                  ],
                                ).show();
                              }),
                        ],
                      ),
                      Text(value.quotes.elementAt(index).text ?? ""),
                    ],
                  ),
                  subtitle:
                  Text(value.quotes.elementAt(index).category?.name ?? ""),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
    );
  }
}
