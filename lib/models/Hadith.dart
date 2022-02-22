class Hadith {
  List<Data> data;
 
  Hadith({this.data, });

  Hadith.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class Data {
  int id;
  String title;
  String descriptionAr;
  String descriptionEn;
  String descriptionFr;
  String audio;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.title,

      this.descriptionAr,
      this.descriptionEn,
      this.descriptionFr,
      this.audio,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    descriptionFr = json['description_fr'];
    audio = json['audio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
     data['id'] = this.id;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['description_fr'] = this.descriptionFr;
    data['audio'] = this.audio;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



