import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

class Contactus extends StatelessWidget {
  Future<void> _launched;

  Future<void> makingwhatsapp(
    String num,
  ) async {
    if (!await launch(
      'https://api.whatsapp.com/send?phone=$num',
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $num';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendemail(String url) async {
    final Uri _emailLaunchUri =
        Uri(scheme: 'mailto', path: url, queryParameters: {'subject': ' '});
    launch(_emailLaunchUri.toString());
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () async {
                await Provider.of<Userprovider>(context, listen: false)
                    .clearuserdata();
                await Provider.of<Lanprovider>(context, listen: false)
                    .cleardata();
                Navigator.of(context).pushReplacementNamed(Login.route);
              },
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Icon(
                    Provider.of<Lanprovider>(context, listen: false).islogin
                        ? Icons.logout
                        : Icons.login,
                    size: 35,
                    color: Colors.black,
                  )),
            ),
          ),
          SizedBox(height: 10,),
          Text(
            'Your free trial has ended, You can contact us for subscribe: ',
            style: GoogleFonts.roboto(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              _sendemail(' info@royaltechni.com');
            },
            child: Text(
              '• By email: info@royaltechni.com ',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              _launched = _launchInBrowser('https://www.royaltechni.com');
            },
            child: Text(
              '• By visiting this page on our website: https://www.royaltechni.com ',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              _makePhoneCall('tel:971553114946');
            },
            child: Text(
              '• By phone number: +971553114946 ',
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.blue),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () async {
                    _launched = _launchInBrowser(
                        'https://www.facebook.com/Royaltechni/');
                  },
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.white,
                        size: 35,
                      )),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await makingwhatsapp('+971 55 311 4946');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                        size: 35,
                      )),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  _launched = _launchInBrowser(
                      'https://instagram.com/royal_techni?utm_medium=copy_link');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.white,
                        size: 35,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
