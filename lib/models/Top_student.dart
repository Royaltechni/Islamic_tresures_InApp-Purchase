class Topstudents {
  List<Hadithhh> hadith;
  List<Azkar> azkar;
  List<Salah> salah;
  List<Quran> quran;

  Topstudents({this.hadith, this.azkar, this.salah, this.quran});

  Topstudents.fromJson(Map<String, dynamic> json) {
    if (json['hadith'] != null) {
      hadith = new List<Hadithhh>();
      json['hadith'].forEach((v) {
        hadith.add(new Hadithhh.fromJson(v));
      });
    }
    if (json['azkar'] != null) {
      azkar = new List<Azkar>();
      json['azkar'].forEach((v) {
        azkar.add(new Azkar.fromJson(v));
      });
    }
    if (json['salah'] != null) {
      salah = new List<Salah>();
      json['salah'].forEach((v) {
        salah.add(new Salah.fromJson(v));
      });
    }
    if (json['quran'] != null) {
      quran = new List<Quran>();
      json['quran'].forEach((v) {
        quran.add(new Quran.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hadith != null) {
      data['hadith'] = this.hadith.map((v) => v.toJson()).toList();
    }
    if (this.azkar != null) {
      data['azkar'] = this.azkar.map((v) => v.toJson()).toList();
    }
    if (this.salah != null) {
      data['salah'] = this.salah.map((v) => v.toJson()).toList();
    }
    if (this.quran != null) {
      data['quran'] = this.quran.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hadithhh {
  String name;
  int userId;
  String hadith;

  Hadithhh({this.name, this.userId, this.hadith});

  Hadithhh.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    hadith = json['hadith'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['hadith'] = this.hadith;
    return data;
  }
}

class Azkar {
  String name;
  int userId;
  String azkar;

  Azkar({this.name, this.userId, this.azkar});

  Azkar.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    azkar = json['azkar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['azkar'] = this.azkar;
    return data;
  }
}

class Salah {
  int id;
  String name;

  int totalGrade;

  Salah({this.id, this.name, this.totalGrade});

  Salah.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];

    totalGrade = json['total_grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_grade'] = this.totalGrade;
    return data;
  }
}

class Quran {
  String name;
  int userId;
  String quran;

  Quran({this.name, this.userId, this.quran});

  Quran.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    quran = json['quran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['quran'] = this.quran;
    return data;
  }
}
