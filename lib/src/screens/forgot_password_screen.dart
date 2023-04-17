// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:music_app/src/utils/constants/app_colors.dart';
import 'package:music_app/src/utils/constants/app_font.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 22,
                          fontFamily: "AppFont",
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: height * 0.02),
                    const Text(
                      "Please enter the mail address associated with the account.",
                      style: TextStyle(
                          fontFamily: "AppFont",
                          color: AppColors.whiteColor,
                          fontSize: 17),
                    ),
                    SizedBox(height: height * 0.016),
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
                                    color: Colors.grey, fontFamily: 'AppFont'),
                                fillColor: AppColors.secondaryColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                            validator: (emailValue) {
                              if (emailValue == null || emailValue.isEmpty) {
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
                    SizedBox(height: height * 0.02),
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                            child: Text(
                              "Reset Password",
                              style: AppFont.regular_17,
                            ),
                          ),
                        ))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
