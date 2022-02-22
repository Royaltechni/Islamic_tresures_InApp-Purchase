import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/CheackUserSubscribe.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/models/dialyhadith.dart';
import 'package:kidsapp/providers/hadithprovider.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/dialyhadith.dart';
import 'package:kidsapp/widgets/CheckSubscription.dart';
import 'package:kidsapp/widgets/cheaklogin.dart';
import 'package:kidsapp/widgets/record.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class Hadithsection extends StatefulWidget {
  @override
  _HadithsectionState createState() => _HadithsectionState();
}

class _HadithsectionState extends State<Hadithsection> {
  bool firstrun;
  bool isfavourie;
  List<String> hadithids = [];
  List<ObjectClass> demoData;
  int page = 1;
  bool secondrun = false;
  bool load = false;
  List<Data> names = [];
  List<Data> distinctIds = [];
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    firstrun = true;
    isfavourie = false;
    load = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<Networkprovider>(context, listen: false).cheaknetwork();
    await Provider.of<Hadithprovider>(context, listen: false)
        .fetchhadithlevels();
    await Provider.of<Hadithprovider>(context, listen: false).fetchfavhadith();
    if (page == 1) {
      await Provider.of<Hadithprovider>(context, listen: false)
          .fetchdailyhadith(page);

      if (Dbhandler.instance.dialhadithstatuscode == 200) {
        if (!load) {
          names.addAll(Provider.of<Hadithprovider>(context, listen: false)
              .dailyhadith
              .data);
          distinctIds = names.toSet().toList();
           names.clear();
          demoData = List.generate(distinctIds.length, (i) {
            return ObjectClass(
              checked: false,
            );
          });
        }
        if (Provider.of<Lanprovider>(context, listen: false).islogin) {
          for (int i = 0; i < distinctIds.length; i++) {
            for (int j = 0;
                j <
                    Provider.of<Hadithprovider>(context, listen: false)
                        .favhadith
                        .data
                        .length;
                j++) {
              if (distinctIds[i].id ==
                  Provider.of<Hadithprovider>(context, listen: false)
                      .favhadith
                      .data[j]
                      .hadithId) {
                demoData[i].checked = true;
              }
            }
          }
        }
      }
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            distinctIds.length <=
                Provider.of<Hadithprovider>(context, listen: false)
                    .dailyhadith
                    .meta
                    .total) {
          setState(() {
            secondrun = true;
          });
          await Provider.of<Hadithprovider>(context, listen: false)
              .fetchdailyhadith(++page);
          names.addAll(Provider.of<Hadithprovider>(context, listen: false)
              .dailyhadith
              .data);
          distinctIds.addAll(Provider.of<Hadithprovider>(context, listen: false)
              .dailyhadith
              .data);
              names.clear();

          demoData = List.generate(distinctIds.length, (i) {
            return ObjectClass(
              checked: false,
            );
          });
          if (Provider.of<Lanprovider>(context, listen: false).islogin) {
            for (int i = 0; i < distinctIds.length; i++) {
              for (int j = 0;
                  j <
                      Provider.of<Hadithprovider>(context, listen: false)
                          .favhadith
                          .data
                          .length;
                  j++) {
                if (distinctIds[i].id ==
                    Provider.of<Hadithprovider>(context, listen: false)
                        .favhadith
                        .data[j]
                        .hadithId) {
                  demoData[i].checked = true;
                }
              }
            }
          }

          setState(() {
            secondrun = false;
          });
        }
      });
    }

    setState(() {
      firstrun = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(distinctIds.length);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Networkprovider.cheak == false
          ? Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Check your network connection',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).accentColor)),
                      onPressed: () async {
                        Home.homeindex = 4;

                        await Navigator.push(
                          // or pushReplacement, if you need that
                          context,
                          FadeInRoute(
                            routeName: Home.route,
                            page: Home(),
                          ),
                        );
                      },
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ))
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: firstrun
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Dbhandler.instance.dialhadithstatuscode != 200
                      ? Container(
                          height: double.infinity,
                          child: Image.asset('assets/images/error.jpg'),
                        )
                      : ListView(
                          controller: _scrollController,
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .isenglish
                                      ? 'Levles'
                                      : 'عرض المستويات'),
                                  Switch(
                                    value: Provider.of<Lanprovider>(context,
                                            listen: true)
                                        .islevel,
                                    onChanged: (value) {
                                      Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .changehadithselecet(value);
                                      //       Navigator.of(context).pop();
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                  ),
                                  Text(Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .isenglish
                                      ? 'open Library'
                                      : 'المكتبة العامة'),
                                  Spacer(),
                                  Provider.of<Lanprovider>(context,
                                              listen: false)
                                          .islogin
                                      ? GestureDetector(
                                          onTap: () async {
                                            await Provider.of<Hadithprovider>(
                                                    context,
                                                    listen: false)
                                                .fetchfavhadith();
                                            Provider.of<Lanprovider>(context,
                                                    listen: false)
                                                .changefavourite(
                                                    !Provider.of<Lanprovider>(
                                                            context,
                                                            listen: false)
                                                        .isfavourite);
                                            load = true;
                                          },
                                          child: Icon(
                                            Provider.of<Lanprovider>(context,
                                                        listen: true)
                                                    .isfavourite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 40,
                                            color: Colors.red[800],
                                          ))
                                      : Container()
                                ],
                              ),
                            ),
                            Provider.of<Lanprovider>(context, listen: false)
                                    .islevel
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: Provider.of<Lanprovider>(context,
                                                listen: false)
                                            .isfavourite
                                        ? Provider.of<Hadithprovider>(context,
                                                listen: false)
                                            .favhadith
                                            .data
                                            .length
                                        : distinctIds.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final dialyhadith =
                                              Provider.of<Lanprovider>(context,
                                                          listen: false)
                                                      .isfavourite
                                                  ? Provider.of<Hadithprovider>(
                                                          context,
                                                          listen: false)
                                                      .favhadith
                                                      .data[index]
                                                      .hadiths
                                                      .id
                                                  : distinctIds[index].id;
                                          //added by youssef
                                          if(Provider.of<Userprovider>(context, listen: false).user.active == false&&CheackUserSubscribe.isUserSubscribe==false){
                                            showDialog(
                                              //  barrierDismissible: false, //
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                      content: CheckSubscription());
                                                });
                                            return;
                                          }
                                          !Provider.of<Lanprovider>(context,
                                                      listen: false)
                                                  .islogin
                                              ? await showDialog(
                                                  //  barrierDismissible: false, //
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        content: Cheaklogin());
                                                  })
                                              : await Navigator.push(
                                                  // or pushReplacement, if you need that
                                                  context,
                                                  FadeInRoute(
                                                      routeName:
                                                          Dialyhadith.route,
                                                      page: Dialyhadith(),
                                                      argument: dialyhadith),
                                                );
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 7)
                                                  .add(EdgeInsets.symmetric(
                                                      horizontal:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.01)),
                                          height: 130,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              Provider.of<Lanprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isenglish
                                                                  ? 'Hadith ${index + 1}'
                                                                  : 'الحديث ${index + 1}',
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            child: Text(
                                                              Provider.of<Lanprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isfavourite
                                                                  ? Provider.of<
                                                                              Hadithprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .favhadith
                                                                      .data[
                                                                          index]
                                                                      .hadiths
                                                                      .title
                                                                  : distinctIds[
                                                                          index]
                                                                      .title,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              // textDirection:TextDirection .rtl ,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: Row(
                                                      children: [
                                                        VerticalDivider(
                                                          width: 2,
                                                          endIndent: 10,
                                                          indent: 10,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Provider.of<Lanprovider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isfavourite
                                                                ? Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    size: 35,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        demoData[index]
                                                                            .checked = !demoData[
                                                                                index]
                                                                            .checked;
                                                                      });

                                                                      await Dbhandler
                                                                          .instance
                                                                          .hadithfav(distinctIds[index]
                                                                              .id
                                                                              .toString());
                                                                    },
                                                                    child: demoData[index]
                                                                            .checked
                                                                        ? Icon(
                                                                            Icons.favorite,
                                                                            size:
                                                                                35,
                                                                            color:
                                                                                Colors.white,
                                                                          )
                                                                        : Icon(
                                                                            Icons.favorite_border,
                                                                            size:
                                                                                35,
                                                                            color:
                                                                                Colors.white,
                                                                          ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        Provider.of<Hadithprovider>(context)
                                            .hadithlevles
                                            .levels
                                            .length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: ExpandableNotifier(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            children: <Widget>[
                                              ScrollOnExpand(
                                                scrollOnExpand: true,
                                                scrollOnCollapse: true,
                                                child: Container(
                                                  //   color: Colors.amber,
                                                  child: ExpandablePanel(
                                                    theme:
                                                        const ExpandableThemeData(
                                                      headerAlignment:
                                                          ExpandablePanelHeaderAlignment
                                                              .center,
                                                      hasIcon: false,
                                                      tapBodyToCollapse: true,
                                                    ),
                                                    header: Card(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      child: Container(
                                                        height: 60,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(
                                                            Provider.of<Lanprovider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isenglish
                                                                ? "Level ${index + 1}"
                                                                : "المستوى ${index + 1}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    expanded: Container(
                                                      height:
                                                          Provider.of<Hadithprovider>(
                                                                      context)
                                                                  .hadithlevles
                                                                  .levels[index]
                                                                  .allhadiths
                                                                  .length *
                                                              145.toDouble(),
                                                      child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: Provider
                                                                  .of<Hadithprovider>(
                                                                      context)
                                                              .hadithlevles
                                                              .levels[index]
                                                              .allhadiths
                                                              .length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            return GestureDetector(
                                                              onTap: () async {
                                                                final dialyhadith = Provider.of<
                                                                            Hadithprovider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .hadithlevles
                                                                    .levels[
                                                                        index]
                                                                    .allhadiths[
                                                                        i]
                                                                    .id;
                                                                AudioRecorder
                                                                        .dialy =
                                                                    true;
                                                                //added by youssef
                                                                if(Provider.of<Userprovider>(context, listen: false).user.active == false&&CheackUserSubscribe.isUserSubscribe==false){
                                                                  showDialog(
                                                                    //  barrierDismissible: false, //
                                                                      context: context,
                                                                      builder: (_) {
                                                                        return AlertDialog(
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                BorderRadius.circular(
                                                                                    15)),
                                                                            content: CheckSubscription());
                                                                      });
                                                                  return;
                                                                }
                                                                !Provider.of<Lanprovider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .islogin
                                                                    ? await showDialog(
                                                                        //  barrierDismissible: false, //
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (_) {
                                                                          return AlertDialog(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                              content: Cheaklogin());
                                                                        })
                                                                    :!Provider.of<Lanprovider>(context, listen: false)
                                                                            .islogin
                                                                        ? await showDialog(
                                                                            //  barrierDismissible: false, //
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (_) {
                                                                              return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), content: Cheaklogin());
                                                                            })
                                                                        : Navigator
                                                                            .push(
                                                                            // or pushReplacement, if you need that
                                                                            context,
                                                                            FadeInRoute(
                                                                                routeName: Dialyhadith.route,
                                                                                page: Dialyhadith(),
                                                                                argument: dialyhadith),
                                                                          );
                                                              },
                                                              child: Container(
                                                                height: 130,
                                                                margin: EdgeInsets.symmetric(
                                                                    horizontal: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.07,
                                                                    vertical:
                                                                        8),
                                                                child: Card(
                                                                    elevation:
                                                                        5,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10)),
                                                                    color: Colors
                                                                        .white,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                CircleAvatar(
                                                                                  radius: 20,
                                                                                  backgroundColor: Colors.black,
                                                                                  child: CircleAvatar(
                                                                                      radius: 19,
                                                                                      backgroundColor: Colors.white,
                                                                                      child: Icon(
                                                                                        Icons.check_sharp,
                                                                                        color: Colors.black,
                                                                                      )),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 10),
                                                                            child:
                                                                                Text(
                                                                              Provider.of<Hadithprovider>(context).hadithlevles.levels[index].allhadiths[i].title,
                                                                              textAlign: TextAlign.center,
                                                                              softWrap: true,
                                                                              overflow: TextOverflow.fade,
                                                                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                    builder: (_, collapsed,
                                                        expanded) {
                                                      return Expandable(
                                                        collapsed: collapsed,
                                                        expanded: expanded,
                                                        theme:
                                                            const ExpandableThemeData(
                                                                crossFadePoint:
                                                                    0),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                      );
                                    },
                                  ),
                            secondrun
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                          ],
                        )),
    );
  }
}

class ObjectClass {
  bool checked;
  ObjectClass({
    this.checked,
  });
}
