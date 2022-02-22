import 'package:flutter/material.dart';
import 'package:kidsapp/models/Allrecord.dart';
import 'package:kidsapp/models/Hadith.dart';
import 'package:kidsapp/models/Hadithbyid.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/models/dialyhadith.dart';
import 'package:kidsapp/models/favouritehadith.dart';
import 'package:kidsapp/models/hadithlevel.dart';

class Hadithprovider with ChangeNotifier {
  Hadith azkar;
  Dailyhadith dailyhadith;
  Hadithlevel hadithlevles;
  Favouritehadith favhadith;
  Allrecord allhadithrecord;
  Hadithbyid hadithid;
  Future<void> fetchallhadith() async {
    try {
      azkar = await Dbhandler.instance.getallhadith();
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }

  Future<void> fetchdailyhadith(int page) async {
    try {
      dailyhadith = await Dbhandler.instance.getdialyhadith(page);
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }

  Future<void> fetchhadithlevels() async {
    try {
      hadithlevles = await Dbhandler.instance.gethadithleevel();
     // print(hadithlevles.levels[0].allhadiths[0].title);
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }
  Future<void> fetchfavhadith() async {
    try {
      favhadith = await Dbhandler.instance.getfavouritehadith();
     // print(hadithlevles.levels[0].allhadiths[0].title);
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }
   Future<void> fetchallhadithrecord(int hadithid) async {
    try {
      allhadithrecord = await Dbhandler.instance.getallhadithrecord(hadithid);
      print(allhadithrecord.records.length);
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }
   Future<void> fetchhadithbyid(int id) async {
    try {
      hadithid = await Dbhandler.instance.getspecifichadith(id);
      
    } catch (error) {
      print('errorrrrrrrrrrrrrr');
    }
  }
}
