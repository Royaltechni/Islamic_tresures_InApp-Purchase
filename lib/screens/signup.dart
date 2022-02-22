import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/Home.dart';
import 'package:kidsapp/screens/login.dart';
import 'package:kidsapp/widgets/background.dart';
import 'package:kidsapp/widgets/navigation.dart';

import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Signup extends StatefulWidget {
  static const String route = 'Signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool login;
  bool hidepassword, hideconfirmpassword;
  TextEditingController password, username, cpassword, phone, email;
  GlobalKey<FormState> form;
  FocusNode passwordnode;
  FocusNode cpasswordnode;
  FocusNode phonenode;
  FocusNode emailnode;
  bool loading;
  GlobalKey<ScaffoldState> scaffold;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    login = true;
    hidepassword = true;
    scaffold = GlobalKey<ScaffoldState>();
    hideconfirmpassword = true;
    form = GlobalKey<FormState>();
    passwordnode = FocusNode();
    cpasswordnode = FocusNode();
    emailnode = FocusNode();
    phonenode = FocusNode();

    loading = false;
    username = TextEditingController();
    password = TextEditingController();
    cpassword = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordnode.dispose();
    emailnode.dispose();
    cpasswordnode.dispose();
    phonenode.dispose();
  }

  void validatetologin() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });

      Userprovider.username = username.text;
      String error = await Provider.of<Userprovider>(context, listen: false)
          .signup(username.text, password.text, cpassword.text, phone.text,
              email.text);

      if (error != null) {
        // ignore: deprecated_member_use
        scaffold.currentState.showSnackBar(SnackBar(
          content: Text('invalid email'),
          backgroundColor: Colors.red[600],
        ));

        setState(() {
          loading = false;
        });
      } else {
        Provider.of<Lanprovider>(context, listen: false).changeLoggedin(true);
        setState(() {
          loading = false;
        });
        Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (BuildContext context) => Home()));
        // Alert(
        //   context: context,
        //   type: AlertType.success,
        //   title: "Congratulations",
        //   desc:
        //       "You have signed up successfully to Islamic Treasures. Your free trial for one week",
        //   buttons: [
        //     DialogButton(
        //       child: Text(
        //         "Ok",
        //         style: TextStyle(color: Colors.white, fontSize: 20),
        //       ),
        //       onPressed: () => Navigator.pushReplacement(context,
        //           MaterialPageRoute(builder: (BuildContext context) => Home())),
        //       color: Color.fromRGBO(0, 179, 134, 1.0),
        //       radius: BorderRadius.circular(0.0),
        //     ),
        //   ],
        // ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
          key: scaffold,
          backgroundColor: Color.fromARGB(24, 178, 223, 9),
          body: Container(
            height: double.infinity,
            child: Stack(
              children: [
                Background(),
                SingleChildScrollView(
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.07),
                          child: Image.asset(
                            'assets/images/bss.png',
                            height: 250,
                            width: 250,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Form(
                          key: form,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: username,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 8.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent[900]),
                                  hintText: '  user name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),

                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                    //   borderRadius: BorderRadius.all(),
                                  ),
                                ),
                                onFieldSubmitted: (value) {
                                  passwordnode.requestFocus();
                                },
                                validator: (value) {
                                  if (username.text.length > 0) {
                                    return null;
                                  }
                                  return 'empty username ';
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              TextFormField(
                                controller: password,
                                maxLines: 1,
                                obscureText: true,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 8.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent[900]),
                                  hintText: '  password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),

                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                    //   borderRadius: BorderRadius.all(),
                                  ),
                                ),
                                onFieldSubmitted: (value) {
                                  cpasswordnode.requestFocus();
                                },
                                validator: (value) {
                                  if (password.text.length > 5) {
                                    return null;
                                  }
                                  return 'Password must contain 6 charcters at least ';
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: passwordnode,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              TextFormField(
                                controller: cpassword,
                                maxLines: 1,
                                obscureText: true,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 8.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent[900]),
                                  hintText: '  confirm password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),

                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                    //   borderRadius: BorderRadius.all(),
                                  ),
                                ),
                                onFieldSubmitted: (value) {
                                  phonenode.requestFocus();
                                },
                                validator: (value) {
                                  if (cpassword.text == password.text) {
                                    return null;
                                  }
                                  return 'Passwords do NOT match ';
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: cpasswordnode,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              TextFormField(
                                controller: phone,
                                maxLines: 1,
                                obscureText: false,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 8.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent[900]),
                                  hintText: '  phone',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),

                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                    //   borderRadius: BorderRadius.all(),
                                  ),
                                ),
                                onFieldSubmitted: (value) {
                                  emailnode.requestFocus();
                                },
                                  validator: (value) {
                                if (phone.text.length > 5) {
                                  return null;
                                }
                                return 'invalid number ';
                              },
                                textInputAction: TextInputAction.next,
                                focusNode: phonenode,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              TextFormField(
                                controller: email,
                                maxLines: 1,
                                obscureText: false,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 8.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent[900]),
                                  hintText: ' email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),

                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white),
                                    //   borderRadius: BorderRadius.all(),
                                  ),
                                ),
                                  validator: (value) {
                                if (EmailValidator.validate(email.text)) {
                                  return null;
                                }
                                return 'invalid email ';
                              },
                                textInputAction: TextInputAction.done,
                                focusNode: emailnode,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 40,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.transparent)),
                                      onPressed: () async {
                                        Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .changeLanguage(
                                                !Provider.of<Lanprovider>(
                                                        context,
                                                        listen: false)
                                                    .isenglish);
                                      },
                                      child: Text(
                                        Provider.of<Lanprovider>(context,
                                                    listen: true)
                                                .isenglish
                                            ? 'العربية'
                                            : 'En',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              loading
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2),
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white)),
                                          onPressed: () async {
                                            validatetologin();
                                            Provider.of<Lanprovider>(context,
                                                    listen: false)
                                                .savedate();
                                          },
                                          child: Text(
                                            Provider.of<Lanprovider>(context,
                                                        listen: true)
                                                    .isenglish
                                                ? 'Sign up'
                                                : 'تسجيل',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )),
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ' Have an account?',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        // or pushReplacement, if you need that
                                        context,
                                        FadeInRoute(
                                          routeName: Login.route,
                                          page: Login(),
                                        ),
                                      );
                                    },
                                    child: Text('Login',
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
