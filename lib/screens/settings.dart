import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/privacy.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/text.dart';

import 'aboutus.dart';
import 'inAppPurchese.dart';
import 'login.dart';

class Settings extends StatelessWidget {
  static const String route = '/Settings';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Provider.of<Lanprovider>(context, listen: false).isenglish
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        //    mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 35,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
                child: Container(
                  child: Text(
                    'Islamic Treasures',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        letterSpacing: .5,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    // or pushReplacement, if you need that
                    context,
                    FadeInRoute(
                      routeName: Aboutus.route,
                      page: inAppPurchese(),
                    ),
                  );
                },
                title: Text(
                  Provider.of<Lanprovider>(context).isenglish
                      ? 'Subscription'
                      : ' الإشتراك',
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    // or pushReplacement, if you need that
                    context,
                    FadeInRoute(
                      routeName: Aboutus.route,
                      page: Aboutus(),
                    ),
                  );
                },
                title: Text(
                  Provider.of<Lanprovider>(context).isenglish
                      ? 'Contact us'
                      : ' معلومات عنا',
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(
                  Icons.contact_support_sharp,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    // or pushReplacement, if you need that
                    context,
                    FadeInRoute(
                      routeName: Privacy.route,
                      page: Privacy(),
                    ),
                  );
                },
                title: Text(
                  Provider.of<Lanprovider>(context).isenglish
                      ? 'Children\'s privacy'
                      : 'خصوصية الاطفال',
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(
                  Icons.privacy_tip,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Provider.of<Lanprovider>(context, listen: false)
                      .changeLanguage(
                          !Provider.of<Lanprovider>(context, listen: false)
                              .isenglish);
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Provider.of<Lanprovider>(context, listen: true).isenglish
                          ? 'العربية'
                          : 'English',
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(
                  FontAwesomeIcons.language,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                onTap: () async {
                  await Provider.of<Userprovider>(context, listen: false)
                      .clearuserdata();
                  await Provider.of<Lanprovider>(context, listen: false)
                      .cleardata();
                  Navigator.of(context).pushReplacementNamed(Login.route);
                },
                title: Text(
                  Provider.of<Lanprovider>(context).isenglish
                      ? 'Logout'
                      : 'تسجيل خروج',
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(
                  Provider.of<Lanprovider>(context).islogin
                      ? Icons.logout
                      : Icons.login,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
