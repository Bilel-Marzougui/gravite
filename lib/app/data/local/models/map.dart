class Maps {
  String lat;
  String lng;
  String id;
  String img;
  String type;

  Maps({this.lat, this.lng, this.id, this.img, this.type});

  Maps.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    id = json['id'];
    img = json['img'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['id'] = this.id;
    data['img'] = this.img;
    data['type'] = this.type;
    return data;
  }
}