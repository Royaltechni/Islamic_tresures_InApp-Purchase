class Favouritehadith {
  List<Resualt> data;

  Favouritehadith({this.data});

  Favouritehadith.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = new List<Resualt>();
      json['Data'].forEach((v) {
        data.add(new Resualt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resualt {
  int id;
  int hadithId;
  int userId;
  String createdAt;
  String updatedAt;
  Data hadiths;

  Resualt(
      {this.id,
      this.hadithId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.hadiths});

  Resualt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hadithId = json['hadith_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hadiths =
        json['hadiths'] != null ? new Data.fromJson(json['hadiths']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hadith_id'] = this.hadithId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hadiths != null) {
      data['hadiths'] = this.hadiths.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String description;
  String audio;
  int levelId;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.title,
      this.description,
      this.audio,
      this.levelId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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