import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/quraanprovider.dart';
import 'package:kidsapp/screens/namesofallah.dart' as namesofallah;
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/widgets/iconplay.dart';

import 'package:provider/provider.dart';

class Allrecordquraandialog extends StatefulWidget {
  final int juzid;
  final int souraid;
  Allrecordquraandialog(this.juzid, this.souraid);
  @override
  _AllrecorddialogState createState() => _AllrecorddialogState();
}

class _AllrecorddialogState extends State<Allrecordquraandialog> {
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
    await Provider.of<Quraanprovider>(context, listen: false)
        .fetchallrecord(this.widget.juzid, this.widget.souraid);

    demoData = List.generate(
        Provider.of<Quraanprovider>(context, listen: false)
            .allrecord
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
                : Provider.of<Quraanprovider>(context, listen: false)
                        .allrecord
                        .records
                        .isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              'You didn\'t record this Sarah yet',
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
                              itemCount: Provider.of<Quraanprovider>(context,
                                      listen: false)
                                  .allrecord
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
                                            Provider.of<Quraanprovider>(context,
                                                    listen: false)
                                                .allrecord
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
                                              Provider.of<Quraanprovider>(
                                                      context,
                                                      listen: false)
                                                  .allrecord
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
                                                      .deleterecord(Provider.of<
                                                                  Quraanprovider>(
                                                              context,
                                                              listen: false)
                                                          .allrecord
                                                          .records[index]
                                                          .id);
                                                  await Provider.of<
                                                              Quraanprovider>(
                                                          context,
                                                          listen: false)
                                                      .fetchallrecord(
                                                          this.widget.juzid,
                                                          this.widget.souraid);

                                                  setState(() {
                                                    demoData[index].checked =
                                                        false;
                                                        if( Provider.of<Quraanprovider>(context, listen: false)
                        .allrecord
                        .records
                        .isEmpty){
                          Soura.isrecorded=false;
                        }
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