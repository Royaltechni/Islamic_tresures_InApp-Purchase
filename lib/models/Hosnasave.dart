class Hosnasave {
  List<Result> result;

  Hosnasave({this.result});

  Hosnasave.fromJson(Map<String, dynamic> json) {
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
  int hosnaId;
  int userId;
  int gradeId;
  int grade;
  String date;
  String hijri;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
      this.hosnaId,
      this.userId,
      this.gradeId,
      this.grade,
      this.date,
      this.hijri,
      this.createdAt,
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hosnaId = json['hosna_id'];
    userId = json['user_id'];
    gradeId = json['grade_id'];
    grade = json['grade'];
    date = json['date'];
    hijri = json['hijri'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hosna_id'] = this.hosnaId;
    data['user_id'] = this.userId;
    data['grade_id'] = this.gradeId;
    data['grade'] = this.grade;
    data['date'] = this.date;
    data['hijri'] = this.hijri;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}