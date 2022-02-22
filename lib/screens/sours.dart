import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/models/sour.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/quraanprovider.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class Surz extends StatefulWidget {
  static const String route = 'Surz';
  static bool firstrun;

  @override
  _SurzState createState() => _SurzState();
}

class _SurzState extends State<Surz> {
  List<Data> list = [];

  int i;
  List<ObjectClass> demoData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Surz.firstrun = true;
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<Networkprovider>(context, listen: false).cheaknetwork();
    List<int> arg = ModalRoute.of(context).settings.arguments as List<int>;
    await Provider.of<Quraanprovider>(context, listen: false)
        .fetchayasave(arg[0]);

    if (!mounted) return;
    setState(() {
      Surz.firstrun = false;
    });
  }

  Future<bool> _onWillPop() async {
    print("on will pop");

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<int> arg = ModalRoute.of(context).settings.arguments as List<int>;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          child: Surz.firstrun
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          _onWillPop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 35,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Networkprovider.cheak == false
                        ? Container(
                            //  height: double.infinity,
                            child: Center(
                              child: Text(
                                'Check your network connection',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 30),
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              itemCount: Provider.of<Quraanprovider>(context,
                                      listen: false)
                                  .ayasaves
                                  .result
                                  .length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    List<dynamic> args = [];
                                    // List<int> arg = [];
                                    args.add(Provider.of<Quraanprovider>(
                                            context,
                                            listen: false)
                                        .ayasaves
                                        .result[i]
                                        .quranNumber);
                                    args.add(arg[0]);
                                    args.add(Provider.of<Quraanprovider>(
                                            context,
                                            listen: false)
                                        .ayasaves
                                        .result[i]
                                        .from);
                                    args.add(Provider.of<Quraanprovider>(
                                            context,
                                            listen: false)
                                        .ayasaves
                                        .result[i]
                                        .numberOfVerse);

                                    Navigator.push(
                                      // or pushReplacement, if you need that
                                      context,
                                      FadeInRoute(
                                          routeName: Soura.route,
                                          page: Soura(),
                                          argument: args),
                                    );
                                    print(args);
                                  },
                                  child: Container(
                                    height: 110,
                                    margin: EdgeInsets.all(5),
                                    //  color: Theme.of(context).primaryColor,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Text(
                                            Provider.of<Quraanprovider>(context)
                                                .ayasaves
                                                .result[i]
                                                .surah,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          //        margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            Provider.of<Quraanprovider>(context)
                                                .sour
                                                .data[
                                                    Provider.of<Quraanprovider>(
                                                                context,
                                                                listen: false)
                                                            .ayasaves
                                                            .result[i]
                                                            .quranNumber -
                                                        1]
                                                .name
                                                .split(' ')
                                                .last,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Provider.of<Lanprovider>(context,
                                                        listen: false)
                                                    .isguz2 ==
                                                true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      Provider.of<Quraanprovider>(
                                                              context)
                                                          .ayasaves
                                                          .result[i]
                                                          .numberOfVersrRead
                                                          .toString(),
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.white),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      Provider.of<Quraanprovider>(
                                                              context)
                                                          .ayasaves
                                                          .result[i]
                                                          .numberOfVerse
                                                          .toString(),
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        Provider.of<Lanprovider>(context,
                                                        listen: false)
                                                    .isguz2 ==
                                                true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 5)
                                                        .add(EdgeInsets.only(
                                                            bottom: 5)),
                                                child:
                                                    new LinearPercentIndicator(
                                                  animation: false,
                                                  lineHeight: 10.0,
                                                  animationDuration: 1000,
                                                  percent: Provider.of<
                                                                  Quraanprovider>(
                                                              context,
                                                              listen: false)
                                                          .ayasaves
                                                          .result[i]
                                                          .numberOfVersrRead /
                                                      Provider.of<Quraanprovider>(
                                                              context,
                                                              listen: false)
                                                          .ayasaves
                                                          .result[i]
                                                          .numberOfVerse,
                                                  // center: Text("80.0%"),
                                                  linearStrokeCap:
                                                      LinearStrokeCap.roundAll,
                                                  progressColor: Colors.amber,
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(1),
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                            ),
                          )
                  ],
                ),
        ),
      ),
    );
  }
}
