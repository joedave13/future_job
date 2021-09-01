import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:future_jobs/models/user_model.dart';
import 'package:future_jobs/pages/home_page.dart';
import 'package:future_jobs/pages/signup_page.dart';
import 'package:future_jobs/providers/auth_provider.dart';
import 'package:future_jobs/providers/user_provider.dart';
import 'package:future_jobs/theme.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool isEmailValid = true;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xffFD4F56),
          content: Text(message),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 24,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In',
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Build Your Career',
                  style: subTitleTextStyle,
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/illustration_one.png',
                        width: 242,
                        height: 220,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      cursorColor: Color(0xff4141A4),
                      onChanged: (value) {
                        print(value);
                        bool isValid = EmailValidator.validate(value);
                        print(isValid);
                        if (isValid) {
                          setState(() {
                            isEmailValid = true;
                          });
                        } else {
                          setState(() {
                            isEmailValid = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffF1F0F5),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: isEmailValid
                                ? Color(0xff4141A4)
                                : Color(0xffFD4F56),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: '',
                      ),
                      style: TextStyle(
                        color: isEmailValid
                            ? Color(0xff4141A4)
                            : Color(0xffFD4F56),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: passwordController,
                      cursorColor: Color(0xff4141A4),
                      decoration: InputDecoration(
                        fillColor: Color(0xffF1F0F5),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Color(0xff4141A4),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: '',
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: 400,
                        height: 45,
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                onPressed: () async {
                                  if (emailController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    showError(
                                      'Email dan password tidak boleh kosong!',
                                    );
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    UserModel user = await authProvider.login(
                                      emailController.text,
                                      passwordController.text,
                                    );

                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (user == null) {
                                      showError('Email atau password salah!');
                                    } else {
                                      userProvider.user = user;
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xff4141A4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(66),
                                  ),
                                ),
                                child: Text(
                                  'Sign In',
                                  style: buttonTextStyle,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Create New Account',
                          style: buttonLightTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
