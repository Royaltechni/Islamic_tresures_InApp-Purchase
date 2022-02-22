class Ayacheak {
  List<Result> result;

  Ayacheak({this.result});

  Ayacheak.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  int userId;
  int quranNumber;
  int juza;
  String surah;
  int numberOfVerse;
  String date;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
      this.userId,
      this.quranNumber,
      this.juza,
      this.surah,
      this.numberOfVerse,
      this.date,
      this.createdAt,
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    quranNumber = json['quran_number'];
    juza = json['juza'];
    surah = json['surah'];
    numberOfVerse = json['numberOfVerse'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['quran_number'] = this.quranNumber;
    data['juza'] = this.juza;
    data['surah'] = this.surah;
    data['numberOfVerse'] = this.numberOfVerse;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}