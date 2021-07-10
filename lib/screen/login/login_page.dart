import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class LoginPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  String? email, password;

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    minimumSize: Size(120, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildContainer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: "e-mail",
                          errorStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.email),
                          labelStyle: TextStyle(color: Colors.black45),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email cannot be blank";
                          } else if (!value.contains("@")) {
                            return "email cannot be @@ blank";
                          }
                          return null;
                        },
                        onSaved: (value) => email = value,
                        ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: "password",
                          errorStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.password_rounded),
                          labelStyle: TextStyle(color: Colors.black45),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password cannot be blank";
                          } else if (value.trim().length < 4) {
                            return "password min 4 character";
                          }
                          return null;
                        },
                        onSaved: (value) => password = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: _loginButton,
                        child: Text("Login"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loginButton() {
    final form = _formKey.currentState;
    if (form!.validate()) {

      form.save();
       // auth services


      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  Container buildContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Text(
        "Welcome Login Page !",
        style: TextStyle(
            color: Colors.brown, fontSize: 30, fontWeight: FontWeight.w400),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryLightColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Login",
        style: TextStyle(color: Colors.grey.shade700),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined),
        onPressed: () {},
        color: Colors.black45,
      ),
    );
  }
}
