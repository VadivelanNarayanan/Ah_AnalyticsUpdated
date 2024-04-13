import 'dart:io';

import 'package:ah_analytics/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final registerForm = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  FocusNode namefield = FocusNode();
  FocusNode numberfield = FocusNode();
  FocusNode emailfield = FocusNode();
  FocusNode passwordfield = FocusNode();
  FocusNode confirmpasswordfield = FocusNode();
  bool isLoading = false;
  bool checked = false;
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

  successAlert() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
      return Platform.isAndroid ? AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)
          )
        ),
        title: Text("Success"),
        content: Text("Your Account Has Been Created Successfully"),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              auth.signOut();
              Navigator.pop(context);
              // Navigator.popUntil(context, ModalRoute.withName("/login"));
              Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Login()));
            },
          )
        ]
      )
      : CupertinoAlertDialog(
        title: Text("Success"),
        content: Text("Your Account Has Been Created Successfully"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("OK"),
            onPressed: () {
              auth.signOut();
              Navigator.pop(context);
              Navigator.popUntil( context, ModalRoute.withName("/login"));
            },
          )
        ]
      );
    });
  }
  registerUser() async {
    await auth.createUserWithEmailAndPassword(email: email.text.toLowerCase().trim(),password: this.confirmPassword.text).then((user) async {
      await firestore.collection("user_data").doc(user.user!.uid).set({
        'name': name.text,
        'email': email.text.toLowerCase().trim(),
      });
      print("User UID & DocID : ${user.user!.uid}");
      successAlert();
    }).catchError((error) {
      alert("Oops", error.message);
    });
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Register Account"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Form(
                key: registerForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        'assets/logo/logo.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      focusNode: namefield,
                      controller: name,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(numberfield);
                      },
                      obscureText: false,
                      style: style,
                      decoration: InputDecoration(
                          contentPadding:EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      focusNode: emailfield,
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(passwordfield);
                      },
                      obscureText: false,
                      style: style,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Enter Valid Email ID";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      focusNode: passwordfield,
                      controller: password,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(confirmpasswordfield);
                      },
                      obscureText: hidepassword,
                      style: style,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        } else if (value.length < 6) {
                          return "Password must contains at least 6 characters";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      focusNode: confirmpasswordfield,
                      controller: confirmPassword,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      obscureText: hidepassword,
                      style: style,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        } else if (password.text != value) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    
                    ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            splashFactory: InkRipple.splashFactory,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          ),
                          onPressed: () {
                            if (registerForm.currentState!.validate()) {
                                registerUser();
                            }else{
                               alert("Oops", "Fill all field");
                            }
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
                )
              ),
            ),
          ),
        )
      ),
    );
  }
}
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);