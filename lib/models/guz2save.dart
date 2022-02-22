class Juz2save {
  List<Result> result;

  Juz2save({this.result});

  Juz2save.fromJson(Map<String, dynamic> json) {
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
  int juze;
  int numberOfVersrRead;

  Result({this.juze, this.numberOfVersrRead});

  Result.fromJson(Map<String, dynamic> json) {
    juze = json['juze'];
    numberOfVersrRead = json['numberOfVersrRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['juze'] = this.juze;
    data['numberOfVersrRead'] = this.numberOfVersrRead;
    return data;
  }
}