import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_admin_app/providers/AuthProvider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: ListView(
            children: [
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return "من فضلك ادخل اسم المستخدم";
                  }
                  return null;
                },
                onSaved: (v) {
                  authProvider.username = v;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "من فضلك ادخل كلمة السر";
                  }
                  return null;
                },
                onSaved: (v) {
                  authProvider.password = v;
                },
              ),
              SizedBox(height: 20,),
              RaisedButton.icon(
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    authProvider.login(context);
                  }
                },
                icon: Icon(Icons.login),
                label: Text("دخول"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
