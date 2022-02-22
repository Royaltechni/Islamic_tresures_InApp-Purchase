class Homedata {
  List<LastHadith> lastHadith;
  int countHadith;
  List<LastAzkar> lastAzkar;
  int countAzkar;
  List<LastQuran> lastQuran;
  List<LastSalah> lastSalah;

  Homedata(
      {this.lastHadith,
      this.countHadith,
      this.lastAzkar,
      this.countAzkar,
      this.lastQuran,
      this.lastSalah});

  Homedata.fromJson(Map<String, dynamic> json) {
    if (json['LastHadith'] != null) {
      lastHadith = new List<LastHadith>();
      json['LastHadith'].forEach((v) {
        lastHadith.add(new LastHadith.fromJson(v));
      });
    }
    countHadith = json['CountHadith'];
    if (json['LastAzkar'] != null) {
      lastAzkar = new List<LastAzkar>();
      json['LastAzkar'].forEach((v) {
        lastAzkar.add(new LastAzkar.fromJson(v));
      });
    }
    countAzkar = json['CountAzkar'];
    if (json['LastQuran'] != null) {
      lastQuran = new List<LastQuran>();
      json['LastQuran'].forEach((v) {
        lastQuran.add(new LastQuran.fromJson(v));
      });
    }
    if (json['LastSalah'] != null) {
      lastSalah = new List<LastSalah>();
      json['LastSalah'].forEach((v) {
        lastSalah.add(new LastSalah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastHadith != null) {
      data['LastHadith'] = this.lastHadith.map((v) => v.toJson()).toList();
    }
    data['CountHadith'] = this.countHadith;
    if (this.lastAzkar != null) {
      data['LastAzkar'] = this.lastAzkar.map((v) => v.toJson()).toList();
    }
    data['CountAzkar'] = this.countAzkar;
    if (this.lastQuran != null) {
      data['LastQuran'] = this.lastQuran.map((v) => v.toJson()).toList();
    }
    if (this.lastSalah != null) {
      data['LastSalah'] = this.lastSalah.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastHadith {
  int id;
  int dailyhadithId;
  int userId;
  int gradeId;
  int grade;
  String audio;
  String date;
  String createdAt;
  String updatedAt;
  Hadithh hadith;

  LastHadith(
      {this.id,
      this.dailyhadithId,
      this.userId,
      this.gradeId,
      this.grade,
      this.audio,
      this.date,
    
      this.createdAt,
      this.updatedAt,
      this.hadith});

  LastHadith.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dailyhadithId = json['dailyhadith_id'];
    userId = json['user_id'];
    gradeId = json['grade_id'];
    grade = json['grade'];
    audio = json['audio'];
    date = json['date'];
  
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hadith =
        json['hadith'] != null ? new Hadithh.fromJson(json['hadith']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dailyhadith_id'] = this.dailyhadithId;
    data['user_id'] = this.userId;
    data['grade_id'] = this.gradeId;
    data['grade'] = this.grade;
    data['audio'] = this.audio;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hadith != null) {
      data['hadith'] = this.hadith.toJson();
    }
    return data;
  }
}

class Hadithh {
  int id;
  String title;
  String description;
  String audio;
  int levelId;
  String createdAt;
  String updatedAt;

  Hadithh(
      {this.id,
      this.title,
      this.description,
      this.audio,
      this.levelId,
      this.createdAt,
      this.updatedAt});

  Hadithh.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    audio = json['audio'];
    levelId = json['level_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['audio'] = this.audio;
    data['level_id'] = this.levelId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LastAzkar {
  int id;
  int categoryId;
  int userId;
  int gradeId;
  int grade;
  String date;
  String hijri;
  String createdAt;
  String updatedAt;
  Category category;

  LastAzkar(
      {this.id,
      this.categoryId,
      this.userId,
      this.gradeId,
      this.grade,
      this.date,
      this.hijri,
      this.createdAt,
      this.updatedAt,
      this.category});

  LastAzkar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    gradeId = json['grade_id'];
    grade = json['grade'];
    date = json['date'];
    hijri = json['hijri'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['grade_id'] = this.gradeId;
    data['grade'] = this.grade;
    data['date'] = this.date;
    data['hijri'] = this.hijri;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String title;
  String image;
  String createdAt;
  String updatedAt;

  Category({this.id, this.title, this.image, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title_en'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LastQuran {
  String surah;
  int count;

  LastQuran({this.surah, this.count});

  LastQuran.fromJson(Map<String, dynamic> json) {
    surah = json['surah'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surah'] = this.surah;
    data['count'] = this.count;
    return data;
  }
}

class LastSalah {
  int salah;
  String result;

  LastSalah({this.salah, this.result});

  LastSalah.fromJson(Map<String, dynamic> json) {
    salah = json['salah'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salah'] = this.salah;
    data['result'] = this.result;
    return data;
  }
}