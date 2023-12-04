import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/CategoriesProvider.dart';
import 'package:quotes_admin_app/screens/CategoryQuotesScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoriesProvider categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.getAll();
    return Consumer<CategoriesProvider>(
      builder: (context, value, child) {
        if (value.categories != null) {
          return ListView.separated(
            key: PageStorageKey<int>(2),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(),
            itemCount: value.categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => CategoryQuotesScreen(
                            id: value.categories.elementAt(index).id,
                          )));
                },
                title: Text(value.categories.elementAt(index).name),
                subtitle: Text(
                    value.categories.elementAt(index).quotes_count.toString()),
                trailing: IconButton(
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
                                    value.categories.elementAt(index).id);

                                Navigator.pop(context);
                              }),
                        ],
                      ).show();
                    }),
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
