class Sourarecord {
  bool isFound;
  Record record;

  Sourarecord({this.isFound, this.record});

  Sourarecord.fromJson(Map<dynamic, dynamic> json) {
    isFound = json['is_found'];
    record =
        json['record'] != null ? new Record.fromJson(json['record']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_found'] = this.isFound;
    if (this.record != null) {
      data['record'] = this.record.toJson();
    }
    return data;
  }
}

class Record {
  String audio;

  Record({this.audio});

  Record.fromJson(Map<dynamic, dynamic> json) {
    audio = json['audio'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    return data;
  }
}