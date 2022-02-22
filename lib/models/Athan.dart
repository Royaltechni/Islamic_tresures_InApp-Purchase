class Athan {
  Data data;

  Athan({this.data});

  Athan.fromJson(Map<String, dynamic> json) {
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
  Timings timings;

  Data({this.timings});

  Data.fromJson(Map<String, dynamic> json) {
    timings =
        json['timings'] != null ? new Timings.fromJson(json['timings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timings != null) {
      data['timings'] = this.timings.toJson();
    }
    return data;
  }
}

class Timings {
  String fajr;
  String dhuhr;
  String asr;
  String maghrib;
  String isha;
  

  Timings(
      {this.fajr,
      this.dhuhr,
      this.asr,
      this.maghrib,
      this.isha,
    });

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Dhuhr'] = this.dhuhr;
    data['Asr'] = this.asr;
    data['Maghrib'] = this.maghrib;
    data['Isha'] = this.isha;
    
    return data;
  }
}