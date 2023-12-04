import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/CategoriesProvider.dart';

class AddCategoryPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CategoriesProvider categoriesProvider = Provider.of<CategoriesProvider>(context , listen: false);
    return SingleChildScrollView(
      key: PageStorageKey<int>(5),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "اسم القسم"
              ),
              validator: (v){
                if(v.isEmpty){
                  return "من فضلك ادخل الاسم";
                }
                return null;
              },
              onSaved: (v){
                categoriesProvider.name = v;
              },
            ),
            SizedBox(height: 10,),
            RaisedButton.icon(onPressed: (){
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                categoriesProvider.add();
              }

            },icon: Icon(Icons.save),label: Text("حفظ"),),
          ],
        ),
      ),
    );
  }
}
