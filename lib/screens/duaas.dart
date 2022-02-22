import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/CheackUserSubscribe.dart';
import 'package:kidsapp/models/Categories.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/azkarprovider.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/providers/networkprovider.dart';
import 'package:kidsapp/providers/userprovider.dart';
import 'package:kidsapp/screens/Home.dart';
import 'package:kidsapp/widgets/CheckSubscription.dart';
import 'package:kidsapp/widgets/cheaklogin.dart';
import 'package:kidsapp/widgets/duadetails.dart';
import 'package:kidsapp/widgets/navigation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class Duaas extends StatefulWidget {
  static const String route = 'duaas';

  @override
  _DuaasState createState() => _DuaasState();
}

class _DuaasState extends State<Duaas> {
  bool firstrun;
  bool secondrun = false;
  int page = 1;
  List<Data> names = [];
  List<Data> distinctIds = [];
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstrun = true;
    //  print(getDeviceType());
  }

  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await Provider.of<Networkprovider>(context, listen: false).cheaknetwork();
    final lan = Provider.of<Lanprovider>(context, listen: false).isenglish
        ? 'en'
        : 'ar';
    await Provider.of<Azkarprovider>(context, listen: false)
        .fetchallcatgories(lan, page);
    names.addAll(
        Provider.of<Azkarprovider>(context, listen: false).categories.data);
    distinctIds = names.toSet().toList();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          page <=
              Provider.of<Azkarprovider>(context, listen: false)
                  .categories
                  .meta
                  .lastPage) {
        setState(() {
          secondrun = true;
        });
        await Provider.of<Azkarprovider>(context, listen: false)
            .fetchallcatgories(lan, ++page);
        names.addAll(
            Provider.of<Azkarprovider>(context, listen: false).categories.data);
        distinctIds = names.toSet().toList();
      }
      setState(() {
        secondrun = false;
      });
    });

    if (mounted) {
      setState(() {
        firstrun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).accentColor)),
                        onPressed: () async {
                          Home.homeindex = 2;

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
            : firstrun
                ? Center(child: CircularProgressIndicator())
                : Dbhandler.instance.azkarstatuscode != 200
                    ? Container(
                        height: double.infinity,
                        child: Image.asset('assets/images/error.jpg'),
                      )
                    : ListView(
                        controller: _scrollController,
                        children: [
                          Container(
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              itemCount: distinctIds.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final azakar = distinctIds[index];

                                return GestureDetector(
                                  onTap: () async {
                                    // added by youssef
                                    if(Provider.of<Userprovider>(context, listen: false).user.active == false &&CheackUserSubscribe.isUserSubscribe==false){
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
                                                          BorderRadius.circular(
                                                              15)),
                                                  content: Cheaklogin());
                                            })
                                        : Navigator.pushNamed(
                                            context, Duadetails.route,
                                            arguments: azakar);
                                    },
                                  child: Container(
                                    height:
                                        getDeviceType() == 'phone' ? 190 : 292,
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Container(
                                            height: getDeviceType() == 'phone'
                                                ? 118
                                                : 220,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    distinctIds[index].image,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: getDeviceType() == 'phone'
                                              ? 47
                                              : 67,
                                          child: Text(
                                            distinctIds[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  letterSpacing: .5,
                                                  fontSize:
                                                      getDeviceType() == 'phone'
                                                          ? 14
                                                          : 22),
                                            ),
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
                          ),
                          secondrun
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(),
                        ],
                      ),
      ),
    );
  }
}
