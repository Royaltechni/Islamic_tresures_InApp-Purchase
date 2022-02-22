import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidsapp/models/Allrecord.dart';
import 'package:kidsapp/models/ayaaudio.dart';
import 'package:kidsapp/models/ayacheak.dart';
import 'package:kidsapp/models/ayah.dart';
import 'package:kidsapp/models/ayasaves.dart';
import 'package:kidsapp/models/db.dart';
import 'package:kidsapp/models/guz2save.dart';
import 'package:kidsapp/models/quraanffavourite.dart';
import 'package:kidsapp/models/quraanlevles.dart';
import 'package:kidsapp/models/sour.dart';
import 'package:kidsapp/models/sourafavourite.dart';
import 'package:kidsapp/models/sourarecord.dart';

class Quraanprovider with ChangeNotifier {
  Sour sour;
  Ayah ayah;
  Ayasaves ayasaves;
  Juz2save juz2save;
  Ayacheak ayacheak;
  Sourafavourite quranfavourite;
  Quraanfavourites quraanfavourites;
  Quraanlevels levles;
  Sourarecord sourarecord;
  Allrecord allrecord;
   Ayaaudio ayaaudio;
  Future<void> fetchsour() async {
    try {
      sour = await Dbhandler.instance.getsour();
    
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchayat(int id,int limit) async {
    try {
      ayah = await Dbhandler.instance.getayatbyid(id,limit);
      print(ayah.data.number);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchayasave(int id) async {
    try {
      ayasaves = await Dbhandler.instance.getayasaves(id);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchlevels() async {
    try {
      levles = await Dbhandler.instance.getlevles();
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchjuz2saaves() async {
    try {
      juz2save = await Dbhandler.instance.getguzsaved();
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchayacheak(int id) async {
    try {
      ayacheak = await Dbhandler.instance.getayacheak(id);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchfavouritesour(int id, int souraid) async {
    try {
      quranfavourite = await Dbhandler.instance.getsouraquran(id, souraid);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchquraanfavourite() async {
    try {
      quraanfavourites = await Dbhandler.instance.getfavouritequraan();
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchsourarecord(int juzid, int souraid) async {
    try {
      sourarecord = await Dbhandler.instance.getsourarecord(juzid, souraid);
    } catch (eroor) {
      print(eroor);
    }
  }

  Future<void> fetchallrecord(int juzid, int souraid) async {
    try {
      allrecord = await Dbhandler.instance.getallrecord(juzid, souraid);
    } catch (eroor) {
      print(eroor);
    }
  }
  Future<void> fetchayaaudio(int juzid, int souraid,int ayaid) async {
    try {
      ayaaudio= await Dbhandler.instance.ayaaudio(juzid, souraid,ayaid);
    } catch (eroor) {
      print(eroor);
    }
  }
}
