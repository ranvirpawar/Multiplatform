import 'package:flutter/material.dart';
import 'package:multiplatorm/components/button.dart';
import 'package:multiplatorm/components/textfield.dart';
import 'package:multiplatorm/constant/image_strings.dart';
import 'package:multiplatorm/view/login_screen.dart';
import 'package:multiplatorm/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  final void Function() onTap;
  const RegistrationScreen({super.key, required this.onTap});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  // sign up user
  void signUp() {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password does not match')));
      return;
    }
    //get the auth servicee>(context);

    final authService = Provider.of<AuthService>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      authService.userRegistrationWithEmailAndPassword(
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
                  const SizedBox(height: 20),

                  //welcome back text
                  const Text("Lets Create an Account For You",
                      style: TextStyle(fontSize: 20)),

                  const SizedBox(height: 20),

                  // email textfield
                  RTextFiel(
                    controller: emailController,
                    hintText: 'EMail',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  RTextFiel(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // confirm password
                  RTextFiel(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  // login button
                  CButton(onTap: signUp, text: 'Sign Up'),

                  const SizedBox(height: 20),

                  // not a member text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("already a member?"),
                      const SizedBox(width: 4),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: const Text('Login',
                              style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
