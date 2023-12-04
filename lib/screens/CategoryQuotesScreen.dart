import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/CategoriesProvider.dart';
import 'package:quotes_admin_app/providers/QuotesProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CategoryQuotesScreen extends StatelessWidget {
  final String id;

  const CategoryQuotesScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuotesProvider quotesProvider =
        Provider.of<QuotesProvider>(context, listen: false);

    quotesProvider.getCategory(context , id);

    return Consumer<QuotesProvider>(
      builder: (context, value, child) {
        if (value.category != null) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(value.category.name),
            ),
            body: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 10,
              ),
              itemCount: value.category.quotes.length,
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
                                      value.category.quotes.elementAt(index).text ??
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
                                              value.category.quotes.elementAt(index).id);

                                          Navigator.pop(context);
                                        }),
                                  ],
                                ).show();
                              }),
                        ],
                      ),
                      Text(value.category.quotes.elementAt(index).text ?? ""),
                    ],
                  ),
                  subtitle:
                      Text(value.category.quotes .elementAt(index).category?.name ?? ""),
                );
              },
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
