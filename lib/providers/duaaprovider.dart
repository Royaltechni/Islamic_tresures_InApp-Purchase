import 'package:flutter/material.dart';
import 'package:kidsapp/models/Hadith.dart';
import 'package:kidsapp/models/db.dart';


class Duaaprovider with ChangeNotifier {
 Hadith duaa;
 Future<void> fetchallduaas() async {
    try {
    duaa = await Dbhandler.instance.getallduuas();
  
    } catch (error) {
      print('errorrrrrrrrrrrrrrr');
    }
  }


}
