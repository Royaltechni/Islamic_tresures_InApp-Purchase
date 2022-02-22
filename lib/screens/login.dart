import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/Home.dart';
import 'package:kidsapp/screens/signup.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/widgets/background.dart';
import 'package:kidsapp/widgets/navigation.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String route = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool login;
  bool hidepassword, hideconfirmpassword;
  TextEditingController password, email;
  GlobalKey<FormState> form;
  FocusNode passwordnode;
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
    loading = false;
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordnode.dispose();
  }

  void validatetologin() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });

      Userprovider.username = email.text;
      String error = await Provider.of<Userprovider>(context, listen: false)
          .signInn(email.text, password.text);

      if (error != null) {
        // ignore: deprecated_member_use
        scaffold.currentState.showSnackBar(SnackBar(
          content: Text('invalid username'),
          backgroundColor: Colors.red[600],
        ));
        setState(() {
          loading = false;
        });
      } else {
        Provider.of<Lanprovider>(context, listen: false).changeLoggedin(true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
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
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.07),
                        child: Text(
                          'Islamic Treasures',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                        ),
                      ),
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
                                controller: email,
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
                                 validator: (value) {
                                  if (email.text.length !=0) {
                                    return null;
                                  }
                                  return 'empty email ';
                                },
                                onFieldSubmitted: (value) {
                                  passwordnode.requestFocus();
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
                                 validator: (value) {
                                  if (password.text.length !=0) {
                                    return null;
                                  }
                                  return 'empty password ';
                                },
                                textInputAction: TextInputAction.done,
                                focusNode: passwordnode,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
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
                                                ? 'Login'
                                                : 'تسجيل الدخول',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )),
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              /*
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
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
                                            MaterialStateProperty.all<Color>(
                                                Colors.white)),
                                    onPressed: () async {
                                      Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .changeLoggedin(false);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Home()));
                                    },
                                    child: Text(
                                      Provider.of<Lanprovider>(context,
                                                  listen: true)
                                              .isenglish
                                          ? 'Skip'
                                          : ' تخطى',
                                      style: TextStyle(color: Colors.grey),
                                    )),
                              )
                              */
                              Row(
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                       Navigator.pushReplacement(
                                      // or pushReplacement, if you need that
                                      context,
                                      FadeInRoute(
                                          routeName: Signup.route,
                                          page: Signup(),
                                         ),
                                    );
                                     
                                    },
                                    child: Text('Sign up', style: GoogleFonts.roboto(
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
