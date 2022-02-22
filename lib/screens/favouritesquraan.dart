import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/quraanprovider.dart';
import 'package:kidsapp/screens/soura.dart';
import 'package:kidsapp/screens/sours.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class Favouritesquraanscreen extends StatefulWidget {
  static const route = '/Favouritesquraan';
  @override
  _FavouritesquraanscreenState createState() => _FavouritesquraanscreenState();
}

class _FavouritesquraanscreenState extends State<Favouritesquraanscreen> {
  bool firstrun;
  Future<bool> _onWillPop() async {
    print("on will pop");

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    firstrun = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<Quraanprovider>(context, listen: false)
        .fetchquraanfavourite();
    setState(() {
      firstrun = false;
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          child: firstrun
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :Dbhandler.instance.favouritestatuscode != 200
                    ? Container(
                        height: double.infinity,
                        child: Image.asset('assets/images/error.jpg'),
                      )
                    :  ListView(
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
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        itemCount:
                            Provider.of<Quraanprovider>(context, listen: false)
                                .quraanfavourites
                                .result
                                .length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, i) {
                          return GestureDetector(
                            onTap: () {
                              List<dynamic> args = [];
                              // List<int> arg = [];
                              args.add(Provider.of<Quraanprovider>(context,
                                      listen: false)
                                  .quraanfavourites
                                  .result[i]
                                  .quranNumber);
                              args.add(Provider.of<Quraanprovider>(context,
                                      listen: false)
                                  .quraanfavourites
                                  .result[i]
                                  .juza);
                              args.add(0);
                              args.add(Provider.of<Quraanprovider>(context,
                                      listen: false)
                                  .sour
                                  .data[Provider.of<Quraanprovider>(context,
                                              listen: false)
                                          .quraanfavourites
                                          .result[i]
                                          .quranNumber -
                                      1]
                                  .numberOfAyahs);

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
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 2, right: 2),
                                    child: Text(
                                      Provider.of<Quraanprovider>(context,
                                              listen: false)
                                          .sour
                                          .data[Provider.of<Quraanprovider>(
                                                      context,
                                                      listen: false)
                                                  .quraanfavourites
                                                  .result[i]
                                                  .quranNumber -
                                              1]
                                          .englishName,
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
                                      Provider.of<Quraanprovider>(context,
                                              listen: false)
                                          .sour
                                          .data[Provider.of<Quraanprovider>(
                                                      context,
                                                      listen: false)
                                                  .quraanfavourites
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          Provider.of<Quraanprovider>(context,
                                                  listen: false)
                                              .quraanfavourites
                                              .result[i]
                                              .numberOfVersrRead
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              color: Colors.white),
                                        ),
                                        Spacer(),
                                        Text(
                                          Provider.of<Quraanprovider>(context,
                                                  listen: false)
                                              .sour
                                              .data[Provider.of<Quraanprovider>(
                                                          context,
                                                          listen: false)
                                                      .quraanfavourites
                                                      .result[i]
                                                      .quranNumber -
                                                  1]
                                              .numberOfAyahs
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 5)
                                        .add(EdgeInsets.only(bottom: 5)),
                                    child: new LinearPercentIndicator(
                                      animation: false,
                                      lineHeight: 10.0,
                                      animationDuration: 1000,
                                      percent:                                           Provider.of<Quraanprovider>(context,
                                                  listen: false)
                                              .quraanfavourites
                                              .result[i]
                                              .numberOfVersrRead /
                                          Provider.of<Quraanprovider>(context,
                                                  listen: false)
                                              .sour
                                              .data[Provider.of<Quraanprovider>(
                                                          context,
                                                          listen: false)
                                                      .quraanfavourites
                                                      .result[i]
                                                      .quranNumber -
                                                  1]
                                              .numberOfAyahs,
                                      // center: Text("80.0%"),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.amber,
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  )
                                  
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
