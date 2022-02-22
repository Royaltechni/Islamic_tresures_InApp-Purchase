class Salahsummary {
  String alone;
  String jamah;
  String onTime;
  String late;
  String didntpray;
  String azkaraftersalah;

  Salahsummary({this.alone, this.jamah, this.onTime, this.late});

  Salahsummary.fromJson(Map<String, dynamic> json) {
    alone = json['Alone'];
    jamah = json['Jamah'];
    onTime = json['OnTime'];
    late = json['Late'];
    didntpray = json['didnt pray'];
    azkaraftersalah = json['azkar after salah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Alone'] = this.alone;
    data['Jamah'] = this.jamah;
    data['OnTime'] = this.onTime;
    data['Late'] = this.late;
    data['didnt pray'] = this.didntpray;
    data['zkar after salah'] = this.azkaraftersalah;
    return data;
  }
}
