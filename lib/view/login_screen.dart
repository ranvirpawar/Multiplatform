// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:multiplatorm/components/button.dart';
import 'package:multiplatorm/components/textfield.dart';
import 'package:multiplatorm/constant/image_strings.dart';
import 'package:multiplatorm/constant/text_string.dart';
import 'package:multiplatorm/services/auth/otp_service.dart';
import 'package:multiplatorm/view/otp_screen.dart';
import 'package:multiplatorm/view/registration_screen.dart';
import 'package:multiplatorm/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function() onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // sign in user
  void signIn() {
    //get the auth servicee>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      authService.userSignInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //icon
                  Image.asset(chatLogo, scale: 5),
                  //spaced
                  SizedBox(height: 20),

                  //welcome back text
                  Text(welcomeText, style: TextStyle(fontSize: 20)),

                  SizedBox(height: 20),

                  // email textfield
                  CTextField(
                    controller: emailController,
                    hintText: 'EMail',
                    obscureText: false,
                  ),

                  SizedBox(height: 10),

                  // password textfield
                  CTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  SizedBox(height: 20),

                  // login button
                  isLoading
                      ? CircularProgressIndicator()
                      : CButton(onTap: signIn, text: 'Sign In'),

                  SizedBox(height: 20),
                  // sign in options
                  Text("Or sign in with"),
                  const SizedBox(height: 10),

                  //sign in with mobile
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen()));
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      child: Text(
                        'Sign in with mobile',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  // not a member text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?"),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text('Register',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
