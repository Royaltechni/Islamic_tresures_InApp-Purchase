class Allrecord {
  List<Records> records;

  Allrecord({this.records});

  Allrecord.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  int id;
  String audio;
  String date;

  Records({this.id, this.audio, this.date});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    audio = json['audio'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['audio'] = this.audio;
    data['date'] = this.date;
    return data;
  }
}