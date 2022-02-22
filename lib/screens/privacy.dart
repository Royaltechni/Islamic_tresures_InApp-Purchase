import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:provider/provider.dart';

class Privacy extends StatelessWidget {
  static const String route = '/Privacy';
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: Provider.of<Lanprovider>(context, listen: false).isenglish
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            Provider.of<Lanprovider>(context, listen: false).isenglish
                ? 'Children\'s privacy'
                : ' خصوصية الاطفال',
            style: GoogleFonts.roboto(
              letterSpacing: 0.5,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          child: ListView(
            
            children: [
              Padding(
                padding:   const EdgeInsets.only(left: 12.0,right: 12,top: 12,bottom: 0),
                child: Text(  Provider.of<Lanprovider>(context, listen: false).isenglish
                      ? 'Children\'s Privacy':'خصوصية الاطفال', style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  Provider.of<Lanprovider>(context, listen: false).isenglish
                      ? 'We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please Contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent\'s consent before We collect and use that information.'
                      : 'نحن لا نجمع عن قصد معلومات تعريف شخصية من أي شخص يقل عمره عن 13 عامًاإذا كنت أحد الوالدين أو وصيًا وأنت تعلم أن طفلك قد زودنا ببيانات شخصية ، فيرجى الاتصال بنا. إذا علمنا أننا جمعنا بيانات شخصية من أي شخص يقل عمره عن 13 عامًا  دون التحقق من موافقة الوالدين ، فإننا نتخذ خطوات لإزالة هذه المعلومات من خوادمناإذا احتجنا إلى الاعتماد على الموافقة كأساس قانوني لمعالجة معلوماتك وطلب بلدك موافقة أحد الوالدين ، فقد نطلب موافقة والديك قبل أن نجمع هذه المعلومات ونستخدمها.',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
