import 'package:flutter/material.dart';
import 'package:kidsapp/providers/Athan.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/widgets/salahevluate.dart';
import 'package:provider/provider.dart';

class Elfajar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Salahev(
       Provider.of<Lanprovider>(context,
                                                    listen: false)
                                                .isenglish? 'Fajr':'الفجر',
      Provider.of<Athanprovider>(context).time.data.timings.fajr,
      Colors.lightBlueAccent.shade700,
      Colors.white,
      Colors.white,
      Colors.black,
      '1',
    );
  }
}
