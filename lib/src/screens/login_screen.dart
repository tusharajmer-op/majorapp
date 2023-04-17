// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:music_app/src/router/router_path.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:music_app/src/utils/constants/app_font.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();

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
                              "Welcome Back",
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 22,
                                  fontFamily: 'AppFont',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: height * 0.02),
                            const Text(
                              "Happy to see you again. You can continue where you left off by logging in.",
                              style: AppFont.regular_17,
                            ),
                            SizedBox(height: height * 0.016),
                            Hero(
                                tag: 'emailHero',
                                child: Material(
                                  color: AppColors.bgColor,
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.text,
                                    style: AppFont.regular_17,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.mail_rounded,
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        hintText: "Enter Email",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'AppFont'),
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
                              style: AppFont.regular_17,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
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
                                      fontFamily: 'AppFont'),
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
                                return null;
                              },
                              onChanged: (email) {
                                email.trim();
                              },
                            ),
                            SizedBox(height: height * 0.02),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, forgotPasswordScreen);
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontFamily: 'AppFont',
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                  child:
                                      Text("Login", style: AppFont.regular_17),
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
                          Navigator.pushNamed(context, registerScreen);
                        },
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'New in App Name?',
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 15,
                                    fontFamily: "AppFont")),
                            TextSpan(
                                text: " Register",
                                style: TextStyle(
                                  fontFamily: "AppFont",
                                  fontSize: 15,
                                  color: AppColors.primaryColor,
                                ))
                          ]),
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
