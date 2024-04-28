class News {
  String title;
  String content;
  String img;

  News({this.title, this.content, this.img});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['img'] = this.img;
    return data;
  }
}