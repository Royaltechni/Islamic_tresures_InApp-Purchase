class Active {
  bool active;
  String role;

  Active({this.active, });

  Active.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['role'] = this.role;
    return data;
  }
}