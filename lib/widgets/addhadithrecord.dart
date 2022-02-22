import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Addhadithrecord extends StatefulWidget {
  int hadithid;
  String path;
  Addhadithrecord(this.hadithid, this.path);
  @override
  _ADdredcordState createState() => _ADdredcordState();
}

class _ADdredcordState extends State<Addhadithrecord> {
  bool loading1;
  bool loading2;
  @override
  void initState() {
    loading1 = false;
    loading2 = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(children: [
        loading1
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.only(top: 15),
                width: 220,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(34, 196, 228, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      loading1 = true;
                    });
                    await Dbhandler.instance.strothafithrecord(
                        'yes',
                        this.widget.hadithid.toString(),
                        File(this.widget.path));

                    if (Dbhandler.instance.sourarecord == 200) {
                      return Alert(
                        context: context,
                        type: AlertType.success,
                        title: 'Sent Successfully Well Done!',
                        closeFunction: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Done",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              setState(() {
                                loading1 = false;
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                            radius: BorderRadius.circular(0.0),
                          ),
                        ],
                      ).show();
                    } else {
                      setState(() {
                        loading1 = false;
                      });

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    Provider.of<Lanprovider>(context, listen: false).isenglish
                        ? 'Update The Last Record'
                        : 'تحديث التسجيل الأخير',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
        Provider.of<Userprovider>(context, listen: false).user.role ==
                'external'
            ? Container()
            : loading2
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 220,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(34, 196, 228, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading2 = true;
                        });
                        await Dbhandler.instance.strothafithrecord(
                            'no',
                            this.widget.hadithid.toString(),
                            File(this.widget.path));
                        print(Dbhandler.instance.sourarecord);
                        if (Dbhandler.instance.sourarecord == 200) {
                          return Alert(
                            context: context,
                            type: AlertType.success,
                            title: 'Sent Successfully Well Done!',
                            closeFunction: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Soura.isrecorded = true;
                                  setState(() {
                                    loading2 = false;
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                color: Color.fromRGBO(0, 179, 134, 1.0),
                                radius: BorderRadius.circular(0.0),
                              ),
                            ],
                          ).show();
                        } else {
                          setState(() {
                            loading2 = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        Provider.of<Lanprovider>(context, listen: false)
                                .isenglish
                            ? 'Add new Record'
                            : 'إضافة تسجيل جديد',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
        loading1 || loading1
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 15),
                width: 220,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(34, 196, 228, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Provider.of<Lanprovider>(context, listen: false).isenglish
                        ? 'Cancel'
                        : 'إلغاء',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
      ]),
    );
  }
}
