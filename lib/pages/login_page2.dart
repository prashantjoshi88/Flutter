import 'dart:async';
import 'dart:ui';

import 'package:catlog/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String mobileNumber = "";
  bool changeButton = false;
  bool showOtpScreen = false;
  String enteredOtp = "";
  String verifyOtpError = "";
  String mobileNumberError = "";

   final FlutterSecureStorage storage = FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();

  // Increase the length of the OTP to 6 digits
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  Future<void> sendOtp() async {
    if (mobileNumber.length == 10) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        showOtpScreen = true;
      });
    } else {
      setState(() {
        mobileNumberError = "Please Enter a Valid Mobile Number";
      });
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    setState(() {
      
    verifyOtpError = "";
    });
    // Concatenate the OTP digits for verification
    enteredOtp = otpControllers.map((controller) => controller.text).join();
    if (enteredOtp == "123456") {
      await storage.write(key: 'mobileNumber', value: mobileNumber);
      Navigator.pushNamed(context, MyRoute.userDetailsRoute);
    } else {
      setState(() {
        verifyOtpError = "Incorrect OTP. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/login.png",
                fit: BoxFit.cover,
                height: 300,
              ),
              const SizedBox(
                height: 20.0,
              ),
              if (!showOtpScreen)
                Text(
                  'Enter Mobile Number',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    if (!showOtpScreen)
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          hintText: "Enter Mobile Number",
                          labelText: "Mobile Number",
                        ),
                        onChanged: (value) {
                          mobileNumber = value;
                          mobileNumberError = "";
                          setState(() {});
                        },
                      ),
                    Text(
                      " $mobileNumberError ",
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    if (!showOtpScreen)
                      Material(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => sendOtp(),
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (showOtpScreen)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              6,
                              (index) => SizedBox(
                                width: 40,
                                height: 50,
                                child: Center(
                                  child: TextField(
                                    controller: otpControllers[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      verifyOtpError = "";
                                       setState(() {});
                                      // Automatically move focus to the previous TextField on backspace
                                      if (value.isEmpty && index > 0) {
                                        FocusScope.of(context).previousFocus();
                                      } else if (value.isNotEmpty &&
                                          index < otpControllers.length - 1) {
                                        // Automatically move focus to the next TextField
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            " $verifyOtpError ",
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Material(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () => verifyOtp(context),
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                width: 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Verify',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
