// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/src/services/firebase_auth.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:music_app/src/utils/constants/app_font.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  bool agree = false;
  final _formKey = GlobalKey<FormState>();

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  // void signUpUser() async {
  //   FirebaseAuthMethod(FirebaseAuth.instance).signUpWithEmail(
  //       name: nameController.text,
  //       email: emailController.text,
  //       password: passwordController.text);
  // }

  void clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        reverse: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome to App Name",
                              style: TextStyle(
                                  fontFamily: 'AppFont',
                                  color: AppColors.whiteColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.02),
                            const Text(
                              "Hello, guess you are new around here. You can start using the application after registering.",
                              style: AppFont.regular_17,
                            ),
                            SizedBox(height: height * 0.016),
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              style: AppFont.regular_16,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person,
                                      color: Colors.grey),
                                  filled: true,
                                  hintText: "Enter Name",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'AppFOnt'),
                                  fillColor: AppColors.secondaryColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )),
                              validator: (nameValue) {
                                if (nameValue == null || nameValue.isEmpty) {
                                  return "Please enter your name";
                                }
                                return null;
                              },
                              onChanged: (email) {
                                email.trim();
                              },
                            ),
                            SizedBox(height: height * 0.013),
                            Hero(
                                tag: 'emailHero',
                                child: Material(
                                  color: AppColors.bgColor,
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.text,
                                    style: AppFont.regular_16,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.mail_rounded,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        hintText: "Enter Email",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "AppFont"),
                                        fillColor: AppColors.secondaryColor,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        )),
                                    validator: (emailValue) {
                                      if (emailValue == null ||
                                          emailValue.isEmpty) {
                                        return "Please enter an email";
                                      }
                                      if (!RegExp(r'\S+@\S+\.\S+')
                                          .hasMatch(emailValue)) {
                                        return "Please enter a valid email address";
                                      }

                                      return null;
                                    },
                                  ),
                                )),
                            SizedBox(height: height * 0.013),
                            TextFormField(
                              controller: passwordController,
                              obscureText: isObscure,
                              keyboardType: TextInputType.text,
                              style: AppFont.regular_16,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                  ),
                                  filled: true,
                                  hintText: "Enter Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "AppFont"),
                                  fillColor: AppColors.secondaryColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )),
                              validator: (passwordValue) {
                                if (passwordValue == null ||
                                    passwordValue.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (passwordValue.length < 6) {
                                  return "Password must be atleast 6 characters long";
                                }

                                return null;
                              },
                              onChanged: (email) {
                                email.trim();
                              },
                            ),
                            SizedBox(height: height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 25,
                                  height: 25,
                                  color: Colors.transparent,
                                  child: Checkbox(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3))),
                                    side: const BorderSide(
                                      color: AppColors.whiteColor,
                                    ),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: agree,
                                    onChanged: (value) => setState(() {
                                      agree = value!;
                                    }),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                SizedBox(
                                  width: width * 0.8,
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontFamily: 'AppFont',
                                          fontSize: 15),
                                      children: <TextSpan>[
                                        const TextSpan(
                                          text: 'By registering, I agree to ',
                                        ),
                                        TextSpan(
                                            text: 'Terms & Conditions',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'AppFont',
                                                color: AppColors.primaryColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(
                                                    'https://youtube.com');
                                              }),
                                        const TextSpan(
                                          text: ' and ',
                                        ),
                                        TextSpan(
                                            text: 'Privacy Policy',
                                            style: const TextStyle(
                                                color: AppColors.primaryColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(
                                                    'https://flipkart.com');
                                              }),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (agree == true) {
                                    // signUpUser();
                                    // clearText();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Please agree for Terms & Conditions',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 13.0);
                                  }
                                }
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                  child: Text("Register",
                                      style: AppFont.regular_17),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: 'Already a member?',
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontFamily: "AppFont",
                                      fontSize: 15)),
                              TextSpan(
                                  text: " Login",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontFamily: "AppFont",
                                      fontSize: 15))
                            ]),
                          ),
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
