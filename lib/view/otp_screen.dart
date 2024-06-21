import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multiplatorm/components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiplatorm/constant/colors.dart';
import 'package:multiplatorm/services/auth/otp_service.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  String? _verificationId;
  String? _completePhoneNumber;

  void _sendOtp() async {
    if (_completePhoneNumber != null && _completePhoneNumber!.isNotEmpty) {
      _firebaseService.sendOtp(
        _completePhoneNumber!,
        (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          print(
              "Phone number automatically verified and user signed in: ${FirebaseAuth.instance.currentUser?.uid}");
        },
        (verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
          print("Code sent to $_completePhoneNumber");
          _mobileNoController.clear();
        },
        (FirebaseAuthException error) {
          print("Failed to verify phone number: ${error.message}");
        },
      );
    } else {
      print("Please enter a valid phone number");
    }
  }

  void _verifyOtp() async {
    if (_verificationId != null) {
      String smsCode = _otpController.text.trim();
      await _firebaseService.verifyOtp(_verificationId!, smsCode);
      if (FirebaseAuth.instance.currentUser != null) {
        print(
            "Phone number verified and user signed in: ${FirebaseAuth.instance.currentUser?.uid}");
        _otpController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hey there!",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Sign in/up with your mobile number",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 20),
            IntlPhoneField(
              controller: _mobileNoController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                _completePhoneNumber = phone.completeNumber;
              },
            ),
            SizedBox(height: 20),
            CButton(onTap: _sendOtp, text: 'Send OTP'),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 20),
            CButton(onTap: _verifyOtp, text: 'Verify OTP'),
          ],
        ),
      ),
    );
  }
}
