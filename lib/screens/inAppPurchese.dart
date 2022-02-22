import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/CheackUserSubscribe.dart';
import 'package:kidsapp/models/PaymentInformation.dart';
import 'package:kidsapp/models/db.dart';
import 'package:purchases_flutter/models/offerings_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class inAppPurchese extends StatefulWidget {
  const inAppPurchese({Key key}) : super(key: key);

  @override
  _inAppPurcheseState createState() => _inAppPurcheseState();
}

class _inAppPurcheseState extends State<inAppPurchese> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _launched;

  @override
  Widget build(BuildContext context) {
    if (CheackUserSubscribe.isUserSubscribe == true) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF090F13),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 450,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Image.asset(
                              'assets/images/pay.jpeg',
                              width: MediaQuery.of(context).size.width,
                              height: 450,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.9, -0.84),
                            child: IconButton(
                              hoverColor: Colors.transparent,
                              iconSize: 48,
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: Color.fromRGBO(184, 95, 143, 1),
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Unlimited Access',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$10.99/year',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0xFF0F181F),
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6, 2, 6, 2),
                                  child: Text('Annual',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0xFF0F181F),
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6, 2, 6, 2),
                                  child: Text(
                                    'premium',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Color(0xFF353D43),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text(
                            'Ratings',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              '100%',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              'SALA',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/Group 2451.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              '100%',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              'ATHKAR ',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/Group 2453.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              '100%',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              'QURAN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/Group 6.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text('Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                          ),
                          Text(
                            'One Year Full Access on Dashboard \nTracking your Level \nAdd Your Favourite Verses On Favourite List \nHelp You Memorize Quran,Hadith and Names Of Allah',
                            style: TextStyle(height: 1.5, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launched = _launchInBrowser(
                                  'https://www.freeprivacypolicy.com/live/041f5375-0215-4eb8-a2d2-23623843219e');
                            },
                            child: Text(
                              'Terms of use',
                              style: GoogleFonts.roboto(
                                  fontSize: 18, color: Colors.blue),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launched = _launchInBrowser(
                                  'https://www.freeprivacypolicy.com/live/041f5375-0215-4eb8-a2d2-23623843219e');
                            },
                            child: Text(
                              'Privacy policy',
                              style: GoogleFonts.roboto(
                                  fontSize: 18, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.white,
                      minWidth: 300,
                      height: 50,
                      onPressed: () {
                        restoringPurchases();
                      },
                      child: Text(
                        "Restoring Purchases".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B39EF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF090F13),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 450,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Image.asset(
                              'assets/images/pay.jpeg',
                              width: MediaQuery.of(context).size.width,
                              height: 450,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.9, -0.84),
                            child: IconButton(
                              hoverColor: Colors.transparent,
                              iconSize: 48,
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: Color.fromRGBO(184, 95, 143, 1),
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Unlimited Access',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$10.99/year',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0xFF0F181F),
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6, 2, 6, 2),
                                  child: Text('Annual',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0xFF0F181F),
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6, 2, 6, 2),
                                  child: Text(
                                    'premium',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Color(0xFF353D43),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text(
                            'Ratings',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              '100%',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              'SALA',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/Group 2451.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              '100%',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              'ATHKAR ',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/Group 2453.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              '100%',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text(
                              'QURAN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/Group 6.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                            child: Text('Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                          ),
                          Text(
                            'One Year Full Access on Dashboard \nTracking your Level \nAdd Your Favourite Verses On Favourite List \nHelp You Memorize Quran,Hadith and Names Of Allah',
                            style: TextStyle(height: 1.5, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launched = _launchInBrowser(
                                  'https://www.freeprivacypolicy.com/live/041f5375-0215-4eb8-a2d2-23623843219e');
                            },
                            child: Text(
                              'Terms of use',
                              style: GoogleFonts.roboto(
                                  fontSize: 18, color: Colors.blue),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launched = _launchInBrowser(
                                  'https://www.freeprivacypolicy.com/live/041f5375-0215-4eb8-a2d2-23623843219e');
                            },
                            child: Text(
                              'Privacy policy',
                              style: GoogleFonts.roboto(
                                  fontSize: 18, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Color(0xFF4B39EF),
                      minWidth: 300,
                      height: 50,
                      onPressed: () {
                        DisplayingAvailableProducts();
                      },
                      child: Text(
                        "Buy  Now".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Colors.white,
                      minWidth: 300,
                      height: 50,
                      onPressed: () {
                        restoringPurchases();
                      },
                      child: Text(
                        "Restoring Purchases".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B39EF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> DisplayingAvailableProducts() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        MakePurchase(offerings);
      }
    } on PlatformException catch (e) {
      // optional error handling
      toastMessage(e.message);
    }
  }

  Future<void> MakePurchase(Offerings offerings) async {
    var myProductList = offerings.current?.availablePackages;
    // Display packages for sale
    try {
      PurchaserInfo purchaserInfo =
          await Purchases.purchasePackage(myProductList[0]);
      var isPro = purchaserInfo.entitlements.all["premium"].isActive;
      if (isPro == true) {
        // Unlock that great "pro" content
        CheackUserSubscribe.isUserSubscribe = true;
        toastMessage("subscription successfully");
        SendPaymentInformation(1, "subscribe");
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        toastMessage(e.message);
      }
    }
  }

  void toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> restoringPurchases() async {
    try {
      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      var isPro = restoredInfo.entitlements.all["premium"].isActive;
      if (isPro == true) {
        toastMessage("Successfully Restoring Purchases");
        SendPaymentInformation(1, "restore");
      }
      Navigator.pop(context, true);
      // ... check restored purchaserInfo to see if entitlement is now active
    } on PlatformException catch (e) {
      // Error restoring purchases
    }
  }

  void SendPaymentInformation(int status, String process_id) async {
    try {
      PaymentInformation paymentInformation =
          await Dbhandler.instance.SendPaymentInformation(status, process_id);
      if (paymentInformation.message == 200) {
        toastMessage("Saved Successfully");
      }
    } catch (error) {
      toastMessage(error.toString());
    }
  }
}
