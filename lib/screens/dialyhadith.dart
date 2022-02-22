import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/models/dialyhadith.dart';
import 'package:kidsapp/providers/hadithprovider.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/widgets/record.dart';
import 'package:kidsapp/widgets/gift.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class Dialyhadith extends StatefulWidget {
  static const String route = '/Dialyhadith';
  static bool isrecorded;
  @override
  _DialyhadithState createState() => _DialyhadithState();
}

class _DialyhadithState extends State<Dialyhadith> {
  bool loading;
  bool firstrun;
  AudioPlayer audioPlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstrun = true;
    loading = false;
    AudioRecorder.dialy = true;
    audioPlayer = AudioPlayer();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    int dialyhadith = ModalRoute.of(context).settings.arguments as int;
    await Provider.of<Hadithprovider>(context, listen: false)
        .fetchhadithbyid(dialyhadith);
  Dialyhadith.isrecorded=false;
    if (Provider.of<Lanprovider>(context, listen: false).islogin) {
      await Provider.of<Hadithprovider>(context, listen: false)
          .fetchallhadithrecord(dialyhadith);

      Provider.of<Hadithprovider>(context, listen: false)
              .allhadithrecord
              .records
              .isEmpty
          ? Dialyhadith.isrecorded = false
          : Dialyhadith.isrecorded = true;
    }
    setState(() {
      firstrun = false;
    });
  }

  Future<bool> _onWillPop() {
    print("on will pop");
    AudioRecorder.dialy = false;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: firstrun
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 10, bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            _onWillPop();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          //       height: MediaQuery.of(context).size.height,
                          child: Html(
                            data:
                                """ ${Provider.of<Hadithprovider>(context, listen: false).hadithid.data.description}""",
                            style: {
                              "div": Style(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  color: Colors.blueAccent),
                            },
                          ),
                        ),
                      ),
                      MyAppp(
                        url: Provider.of<Hadithprovider>(context, listen: false)
                            .hadithid
                            .data
                            .audio,
                        hadithid:
                            Provider.of<Hadithprovider>(context, listen: false)
                                .hadithid
                                .data
                                .id,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.2)
                            .add(EdgeInsets.symmetric(vertical: 10)),
                        child: loading
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).accentColor)),
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  await Dbhandler.instance.Dialyhadithstatus(
                                      'read',
                                      Provider.of<Hadithprovider>(context,
                                              listen: false)
                                          .hadithid
                                          .data
                                          .id
                                          .toString());
                                  setState(() {
                                    loading = false;
                                  });
                                  if (Dbhandler.instance.dialyhadith == 200)
                                    await audioPlayer.setAsset(
                                        'assets/audio/mixkit-achievement-bell-600.wav');
                                  audioPlayer.play();
                                  if (Dbhandler.instance.dialyhadith == 200)
                                    Dialogs.materialDialog(
                                        customView: Container(
                                          child: Gift(
                                            'Masha’ Allah',
                                            'ماشاء الله',
                                            'assets/images/Group 804.png',
                                            Colors.white,
                                            Colors.white,
                                            Color.fromRGBO(255, 72, 115, 1),
                                            Colors.white,
                                            Colors.white,
                                            Color.fromRGBO(255, 72, 115, 1),
                                          ),
                                        ),
                                        titleStyle: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 25),
                                        color: Colors.white,
                                        //    animation: 'assets/cong_example.json',
                                        context: context,
                                        actions: [
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.1),
                                            child: IconsButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              text: 'Done',
                                              color: Color.fromRGBO(
                                                  255, 72, 115, 1),
                                              textStyle: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ]);
                                  else {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
