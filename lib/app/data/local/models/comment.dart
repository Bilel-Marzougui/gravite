class Comment {
  String id;
  String user;
  String comment;
  var bannerPic;
  String date;
  String img;

  Comment(
      {this.id, this.user, this.comment, this.bannerPic, this.date, this.img});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    comment = json['comment'];
    bannerPic = json['banner_pic'];
    date = json['date'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['comment'] = this.comment;
    data['banner_pic'] = this.bannerPic;
    data['date'] = this.date;
    data['img'] = this.img;
    return data;
  }
}