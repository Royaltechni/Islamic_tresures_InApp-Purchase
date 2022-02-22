class Ayaaudio {
  String audio;

  Ayaaudio({this.audio});

  Ayaaudio.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    return data;
  }
}