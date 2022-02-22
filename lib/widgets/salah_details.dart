import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class Salahdetials extends StatelessWidget {
  List<Color> colors = [
    Colors.blue,
    Colors.amber,
    Colors.amber[800],
    Colors.grey,
    Colors.black
  ];
  List<String> salahname = ['Fajr', 'Thuhr', 'Asr', 'Maghrib', 'Isha\''];
  List<String> arabicsalahname = [
    'الفجر',
    'الظهر',
    'العصر',
    'المغرب',
    'العشاء'
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 200,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: 35,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.timeline),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    Provider.of<Lanprovider>(context, listen: false).isenglish
                        ? 'Prayer Tracker for the last 7 day'
                        : 'متتبع الصلاة لاخر ٧ ايام',
                    style: GoogleFonts.lato(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              height: 165,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return GestureDetector(
                    onTap: () async {
                      await Provider.of<Userprovider>(context, listen: false)
                          .fetchsalahsummary(index + 1);
                      Dialogs.materialDialog(
                          customView: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: Provider.of<Lanprovider>(
                                            context,
                                            listen: false)
                                        .isenglish
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .isenglish
                                        ? salahname[index]
                                        : arabicsalahname[index],
                                    style: GoogleFonts.lato(fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                  ),
                                  Divider(),
                                  Text(
                                      Provider.of<Lanprovider>(context,
                                                  listen: false)
                                              .isenglish
                                          ? 'Alone: ' +
                                              Provider.of<Userprovider>(context,
                                                      listen: false)
                                                  .salah
                                                  .alone
                                                  .toString()
                                          : 'منفرداً :' +
                                              Provider.of<Userprovider>(context,
                                                      listen: false)
                                                  .salah
                                                  .alone
                                                  .toString(),
                                      style: GoogleFonts.lato(fontSize: 16),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .isenglish
                                        ? 'jamah: ' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .jamah
                                                .toString()
                                        : 'جماعة :' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .jamah
                                                .toString(),
                                    style: GoogleFonts.lato(fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .isenglish
                                        ? 'Ontime: ' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .onTime
                                                .toString()
                                        : 'فى وقتها :' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .onTime
                                                .toString(),
                                    style: GoogleFonts.lato(fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .isenglish
                                        ? 'Late: ' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .late
                                                .toString()
                                        : ' متأخراً :' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .late
                                                .toString(),
                                    style: GoogleFonts.lato(fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .isenglish
                                        ? 'did\'nt  pray: ' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .didntpray
                                                .toString()
                                        : ' لم اصلى :' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .didntpray
                                                .toString(),
                                    style: GoogleFonts.lato(fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .isenglish
                                        ? 'azkar after salah: ' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .azkaraftersalah
                                                .toString()
                                        : ' أذكار بعد الصلاة :' +
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .salah
                                                .azkaraftersalah
                                                .toString(),
                                    style: GoogleFonts.lato(fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          titleStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 25),
                          color: Colors.white,
                          //    animation: 'assets/cong_example.json',
                          context: context,
                          actions: [
                            Container(
                              height: 40,
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: IconsButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                text: 'Done',
                                color: Color.fromRGBO(34, 196, 228, 1),
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ]);
                    },
                    child: (Container(
                      color: colors[index],
                      width: (MediaQuery.of(context).size.width - 20) / 5,
                      height: 165,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Provider.of<Lanprovider>(context, listen: false)
                                      .isenglish
                                  ? salahname[index]
                                  : arabicsalahname[index],
                              style: GoogleFonts.lato(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              Provider.of<Userprovider>(context, listen: false)
                                  .homedata
                                  .lastSalah[index]
                                  .result,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
