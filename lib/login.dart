import 'dart:io';

import 'package:ah_analytics/home.dart';
import 'package:ah_analytics/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailfield = FocusNode();
  FocusNode passwordfield = FocusNode();
  bool isLoading = false;
  var blank = FocusNode();
  bool hidepassword = true;

  alert(title, msg) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Platform.isAndroid ? AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28))),
          title: Text("$title"),
          content: Text("$msg"),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
        : CupertinoAlertDialog(
          title: Text("$title"),
          content: Text("$msg"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  Future<void> login() async {
    setState(() {
      hidepassword = true;
    });
    print("Login => Email: ${email.text.toLowerCase().trim()} & Password: ${password.text} ");
    try {
      FocusScope.of(context).requestFocus(blank);
      if (email.text.isEmpty) {
        alert("Oops", "Please enter the registered email");
        FocusScope.of(context).requestFocus(emailfield);
      } else if (password.text.isEmpty) {
        alert("Oops", "Please enter your password");
        FocusScope.of(context).requestFocus(passwordfield);
      } else {
        setState(() {
          isLoading = true;
        });
        if (email.text.isNotEmpty && password.text.isNotEmpty) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
           Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Home()));
        } else {
          alert("User Not Found","The profile for the given Email ID is not found. Make sure you have registered in AH-Analytics");
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      alert("Something Went Wrong", "$e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: Text('Yes'),
              ),
            ],
          ),
        );
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 155.0,
                        child: Image.asset('assets/logo/logo.jpg',fit: BoxFit.contain,),
                      ),
                      SizedBox(height: 25.0),
                      TextField(
                        focusNode: emailfield,
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (val) {
                          FocusScope.of(context).requestFocus(passwordfield);
                        },
                        obscureText: false,
                        style: style,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          contentPadding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: "Email",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                        ),
                      ),
                      SizedBox(height: 25.0),
                      TextField(
                        focusNode: passwordfield,
                        controller: password,
                        onSubmitted: (val) {
                          login();
                        },
                        obscureText: hidepassword,
                        style: style,
                        decoration: InputDecoration(
                          contentPadding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: "Password",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            color: Colors.grey,
                            icon: hidepassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                hidepassword = hidepassword ? false : true;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // text color
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          ),
                          onPressed: login,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // text color
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          ),
                          onPressed: () {
                            // Navigator.pushNamed(context, '/register');
                            Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => Register(),
                              settings: const RouteSettings(name: '/register')
                            )
                          );
                          },
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
          // Positioned(
          //   top: 0,
          //   // child: SafeArea(
          //     child: Container(
          //       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          //       width: MediaQuery.of(context).size.width,
          //       decoration: WidgetService().covidBannerTheme,
          //       child: WidgetService().covidBanner(
          //         context,
          //         ()async{
          //           await AppService().gotoCovidSupport(context, null, null, null);
          //         }
          //       ),
          //     ),
          //   // ),
          // ),
        ])
      )
    ); 
  }
}
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);