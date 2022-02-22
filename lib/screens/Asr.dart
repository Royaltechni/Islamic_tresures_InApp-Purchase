import 'package:flutter/material.dart';
import 'package:kidsapp/providers/Athan.dart';
import 'package:kidsapp/providers/lanprovider.dart';

import 'package:kidsapp/widgets/salahevluate.dart';
import 'package:provider/provider.dart';

class Asr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Salahev(
        Provider.of<Lanprovider>(context,
                                                    listen: false)
                                                .isenglish?  'Asr':'العصر',
        Provider.of<Athanprovider>(context).time.data.timings.asr,
        Colors.yellow.shade600,
        Colors.grey[700],
        Colors.black,
        Colors.black,
        '3');
  }
}
