import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:future_jobs/models/user_model.dart';
import 'package:future_jobs/pages/signin_page.dart';
import 'package:future_jobs/providers/auth_provider.dart';
import 'package:future_jobs/providers/user_provider.dart';
import 'package:future_jobs/theme.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isUploaded = false;
  bool isEmailValid = true;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController goalController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    Widget uploadedImage() {
      return Center(
        child: InkWell(
          onTap: () {
            setState(() {
              isUploaded = !isUploaded;
            });
          },
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff2A327D),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/icon_upload.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget showedImage() {
      return Center(
        child: InkWell(
          onTap: () {
            setState(() {
              isUploaded = !isUploaded;
            });
          },
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff2A327D),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/show_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    }

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
              right: 24,
              left: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Begin New Journey',
                  style: subTitleTextStyle,
                ),
                SizedBox(
                  height: 40,
                ),
                isUploaded ? showedImage() : uploadedImage(),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: nameController,
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
                      style: TextStyle(
                        color: Color(0xff4141A4),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
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
                      cursorColor: Color(0xff4141A4),
                      controller: emailController,
                      onChanged: (value) {
                        bool isValid = EmailValidator.validate(value);
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
                      style: TextStyle(
                        color: Color(0xff4141A4),
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
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
                      'Your Goal',
                      style: titleTextStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: goalController,
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
                      style: TextStyle(
                        color: Color(0xff4141A4),
                      ),
                    ),
                  ],
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
                                  passwordController.text.isEmpty ||
                                  nameController.text.isEmpty ||
                                  goalController.text.isEmpty) {
                                showError('Semua field harus diisi!');
                              } else {
                                setState(() {
                                  isLoading = true;
                                });

                                UserModel user = await authProvider.register(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                  goalController.text,
                                );

                                setState(() {
                                  isLoading = false;
                                });

                                if (user == null) {
                                  showError('Email sudah terdaftar!');
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
                              'Sign Up',
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
                          builder: (context) => SigninPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Back to Sign In',
                      style: buttonLightTextStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
