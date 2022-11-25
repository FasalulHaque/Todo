// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/homescreen/view/home.dart';
import 'package:todo/sinup/sing.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Welcome !!......',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      TextField(
                        controller: mailController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border(
                        bottom: BorderSide(color:  Colors.black),
                        top: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                        // ignore: avoid_redundant_argument_values
                        left: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        final auth = FirebaseAuth.instance;
                        try {
                          await auth.signInWithEmailAndPassword(
                            email: mailController.text,
                            password: passwordController.text,
                          );
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.code)));
                          print(e.code);
                          print('Login Failed');
                        }
                      },
                      color: Colors.indigoAccent[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),),
                      child: Text(
                        'Login',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text('Dont have an account?'),
                    TextButton(
                      child: Text(' Register'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          // ignore: inference_failure_on_instance_creation
                          MaterialPageRoute(builder: (context) => Sing()),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
