import 'package:flutter/material.dart';
import 'package:kidsapp/models/Hadith.dart';
import 'package:kidsapp/models/db.dart';


class Deedprovider with ChangeNotifier {
 Hadith dead;
 Future<void> fetchalldeed() async {
    try {
    dead = await Dbhandler.instance.getalldeed();
    
    } catch (error) {
      print('errorrrrr');
    }
  }

}
