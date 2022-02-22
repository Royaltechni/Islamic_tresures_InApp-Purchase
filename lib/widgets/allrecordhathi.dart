import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/hadithprovider.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/quraanprovider.dart';
import 'package:kidsapp/screens/dialyhadith.dart';
import 'package:kidsapp/screens/namesofallah.dart';
import 'package:kidsapp/widgets/iconplay.dart';

import 'package:provider/provider.dart';

class Allrecordhadithdialog extends StatefulWidget {
  final int hadithid;

  Allrecordhadithdialog(
    this.hadithid,
  );
  @override
  _AllrecorddialogState createState() => _AllrecorddialogState();
}

class _AllrecorddialogState extends State<Allrecordhadithdialog> {
  bool firstrun;
  bool loading;
  List<ObjectClass> demoData;
  @override
  void initState() {
    firstrun = true;
    loading = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<Networkprovider>(context, listen: false).cheaknetwork();
    await Provider.of<Hadithprovider>(context, listen: false)
        .fetchallhadithrecord(this.widget.hadithid);

    demoData = List.generate(
        Provider.of<Hadithprovider>(context, listen: false)
            .allhadithrecord
            .records
            .length, (i) {
      return ObjectClass(
        checked: false,
      );
    });
    setState(() {
      firstrun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 300.0,
        child: Networkprovider.cheak == false
            ? Center(
                child: Text(
                  'Check your network connection',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : firstrun
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Provider.of<Hadithprovider>(context, listen: false)
                        .allhadithrecord
                        .records
                        .isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              'You didn\'t record this Hadith yet',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    : ListView(
                        children: [
                          Align(
                            alignment:
                                Provider.of<Lanprovider>(context, listen: false)
                                        .isenglish
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                child: Text(
                                  Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .isenglish
                                      ? 'My Recordings'
                                      : 'تسجيلاتي',
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: Provider.of<Hadithprovider>(context,
                                      listen: false)
                                  .allhadithrecord
                                  .records
                                  .length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            Provider.of<Hadithprovider>(context,
                                                    listen: false)
                                                .allhadithrecord
                                                .records[index]
                                                .date,
                                            style: GoogleFonts.roboto(
                                                fontSize: 15),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Iconsplay(
                                              Provider.of<Hadithprovider>(
                                                      context,
                                                      listen: false)
                                                  .allhadithrecord
                                                  .records[index]
                                                  .audio),
                                        ),
                                      ),
                                      demoData[index].checked
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Container(
                                              width: 100,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors
                                                      .red[600], // background
                                                  onPrimary: Colors
                                                      .white, // foreground
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    demoData[index].checked =
                                                        true;
                                                  });
                                                  await Dbhandler.instance
                                                      .deletehadithrecord(Provider
                                                              .of<Hadithprovider>(
                                                                  context,
                                                                  listen: false)
                                                          .allhadithrecord
                                                          .records[index]
                                                          .id);
                                                  await Provider.of<
                                                              Hadithprovider>(
                                                          context,
                                                          listen: false)
                                                      .fetchallhadithrecord(
                                                          this.widget.hadithid);
                                                  if (Provider.of<
                                                              Hadithprovider>(
                                                          context,
                                                          listen: false)
                                                      .allhadithrecord
                                                      .records
                                                      .isEmpty) {
                                                    Dialyhadith.isrecorded =
                                                        false;
                                                  }

                                                  setState(() {
                                                    demoData[index].checked =
                                                        false;
                                                  });
                                                },
                                                child: Text(
                                                    Provider.of<Lanprovider>(
                                                                context,
                                                                listen: false)
                                                            .isenglish
                                                        ? 'Delete'
                                                        : 'حذف'),
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ));
  }
}
