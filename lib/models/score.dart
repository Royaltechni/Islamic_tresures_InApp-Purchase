class Score {
  int totalScore;

  Score({this.totalScore});

  Score.fromJson(Map<String, dynamic> json) {
    totalScore = json['totalScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalScore'] = this.totalScore;
    return data;
  }
}