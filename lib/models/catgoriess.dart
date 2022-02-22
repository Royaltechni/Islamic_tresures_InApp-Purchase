class Categoriess {
  Data data;

  Categoriess({this.data});

  Categoriess.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String image;
  List<Azkars> azkars;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.title,
      this.image,
      this.azkars,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    if (json['azkars'] != null) {
      azkars = new List<Azkars>();
      json['azkars'].forEach((v) {
        azkars.add(new Azkars.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    if (this.azkars != null) {
      data['azkars'] = this.azkars.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Azkars {
  int id;
  String desciptionAr;
  String desciptionEn;
  String desciptionFr;
  String audio;
  String createdAt;
  String updatedAt;

  Azkars(
      {this.id,
      this.desciptionAr,
      this.desciptionEn,
      this.desciptionFr,
      this.audio,
      this.createdAt,
      this.updatedAt});

  Azkars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desciptionAr = json['desciption_ar'];
    desciptionEn = json['desciption_en'];
    desciptionFr = json['desciption_fr'];
    audio = json['audio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desciption_ar'] = this.desciptionAr;
    data['desciption_en'] = this.desciptionEn;
    data['desciption_fr'] = this.desciptionFr;
    data['audio'] = this.audio;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}