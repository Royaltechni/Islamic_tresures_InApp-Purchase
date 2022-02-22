import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:provider/provider.dart';

class Dialycheaklist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          //
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await Provider.of<Lanprovider>(context, listen: false)
                            .changeLan((!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn));
                        await Dbhandler.instance.activity('done', '1');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Ate Suhoor',
                        //      maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await Provider.of<Lanprovider>(context, listen: false)
                            .changeLan2((!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn2));
                        await Dbhandler.instance.activity('done', '2');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn2
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Gave in Sadaqah',
                      //      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                            letterSpacing: .5,
                            //               fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await Provider.of<Lanprovider>(context, listen: false)
                            .changeLan3((!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn3));
                        await Dbhandler.instance.activity('done', '3');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn3
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Exercised',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Provider.of<Lanprovider>(context, listen: false)
                            .changeLan4((!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn4));
                        await Dbhandler.instance.activity('done', '4');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn4
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Attended halaqa online/offline',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                            letterSpacing: .5,
                            //            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          //
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Provider.of<Lanprovider>(context, listen: false)
                            .changeLan5((!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn5));
                        await Dbhandler.instance.activity('done', '5');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn5
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Kind to self & others',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Provider.of<Lanprovider>(context, listen: false)
                            .changeLan6((!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn6));
                        await Dbhandler.instance.activity('done', '6');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn6
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Hosted/attended Iftar.',
                      //      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                            letterSpacing: .5,
                            //     fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          //
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Provider.of<Lanprovider>(context, listen: false)
                            .changeLan7(!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn7);
                        await Dbhandler.instance.activity('done', '7');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn7
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Greeted everyone with smile',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Provider.of<Lanprovider>(context, listen: false)
                            .changeLan8(!Provider.of<Lanprovider>(context,
                                    listen: false)
                                .isEn8);
                        await Dbhandler.instance.activity('done', '8');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(62, 194, 236, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Provider.of<Lanprovider>(context, listen: true)
                                  .isEn8
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Helped my mum and dad.',
                      //      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(125, 137, 137, 1),
                            letterSpacing: .5,
                            //     fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
