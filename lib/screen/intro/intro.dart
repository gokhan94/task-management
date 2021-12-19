import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/screen/login/login_page.dart';
import 'package:task_management/screen/register/register_page.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/avatar.png"),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Login and Register",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25, color: Colors.orange.shade900),
            ),
          ),
          SizedBox(height: 20,),
          loginAndRegisterButton(context),
        ],
      ),
    ));
  }

  Container loginAndRegisterButton(context) {
    return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.brown),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),
                      ))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return RegisterPage();
                    }));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(10),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                             side: BorderSide(color: Colors.brown)
                          ))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
