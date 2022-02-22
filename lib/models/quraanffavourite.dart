class Quraanfavourites {
  List<Result> result;

  Quraanfavourites({this.result});

  Quraanfavourites.fromJson(Map<String, dynamic> json) {
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
  int quranNumber;
  int juza;
  int numberOfVersrRead;

  Result({this.quranNumber, this.juza, this.numberOfVersrRead});

  Result.fromJson(Map<String, dynamic> json) {
    quranNumber = json['quran_number'];
    juza = json['juza'];
    numberOfVersrRead = json['numberOfVersrRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quran_number'] = this.quranNumber;
    data['juza'] = this.juza;
    data['numberOfVersrRead'] = this.numberOfVersrRead;
    return data;
  }
}