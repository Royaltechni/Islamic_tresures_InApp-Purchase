class Quraanlevels {
  List<Levels> levels;

  Quraanlevels({this.levels});

  Quraanlevels.fromJson(Map<String, dynamic> json) {
    if (json['levels'] != null) {
      levels = new List<Levels>();
      json['levels'].forEach((v) {
        levels.add(new Levels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.levels != null) {
      data['levels'] = this.levels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Levels {
  int level;
  List<Quran> quran;

  Levels({this.level, this.quran});

  Levels.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    if (json['Quran'] != null) {
      quran = new List<Quran>();
      json['Quran'].forEach((v) {
        quran.add(new Quran.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    if (this.quran != null) {
      data['Quran'] = this.quran.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quran {
  int level;
  int quranNumber;
  String surah;
  int from;
  int to;
  int numberOfVerse;
  int numberOfVersrRead;
  int juza;
  Quran(
      {this.level,
      this.quranNumber,
      this.surah,
      this.from,
      this.to,
      this.juza,
      this.numberOfVerse,
      this.numberOfVersrRead});

  Quran.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    quranNumber = json['quran_number'];
    surah = json['surah'];
    from = json['from'];
    to = json['to'];
    juza=json['juza'];
    numberOfVerse = json['numberOfVerse'];
    numberOfVersrRead = json['numberOfVersrRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['quran_number'] = this.quranNumber;
    data['surah'] = this.surah;
    data['from'] = this.from;
    data['juza'] = this.juza;
    data['to'] = this.to;
    data['numberOfVerse'] = this.numberOfVerse;
    data['numberOfVersrRead'] = this.numberOfVersrRead;
    return data;
  }
}