class Product {
  var h;
  var w;
  var x;
  var y;
  var r;
  String id;
  String name;
  int stock;
  var price;
  String currency;
  int comments;
  int likes;
  String designerId;
  var designer;
  String designerProfilePic;
  String img;
  String fullPic;
  String flag;
  String designerCoutry;
  String designerCountryCode;
  String designerCountry;
  String theme;
  List tags;

  Product.withoutname();

  Product(
      {this.h,
        this.w,
        this.x,
        this.y,
        this.r,
        this.id,
        this.name,
        this.stock,
        this.price,
        this.currency,
        this.comments,
        this.likes,
        this.designerId,
        this.designer,
        this.designerProfilePic,
        this.img,
        this.fullPic,
        this.flag,
        this.designerCoutry,
        this.designerCountryCode,
        this.designerCountry,
        this.theme,
        this.tags});

  Product.fromMap(Map json) {
    h = json['h'];
    w = json['w'];
    x = json['x'];
    y = json['y'];
    r = json['r'];
    id = json['id'];
    name = json['name'];
    stock = json['stock'];
    price = json['price'];
    currency = json['currency'];
    comments = json['comments'];
    likes = json['likes'];
    designerId = json['designer_id'];
    designer = json['designer'];
    designerProfilePic = json['designer_profile_pic'];
    img = json['img'];
    fullPic = json['full_pic'];
    flag = json['flag'];
    designerCoutry = json['designer_coutry'];
    designerCountryCode = json['designer_country_code'];
    designerCountry = json['designer_country'];
    theme = json['theme'];
    try{
      tags = json['tags'];

    } catch(e){

    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h'] = this.h;
    data['w'] = this.w;
    data['x'] = this.x;
    data['y'] = this.y;
    data['r'] = this.r;
    data['id'] = this.id;
    data['name'] = this.name;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['designer_id'] = this.designerId;
    data['designer'] = this.designer;
    data['designer_profile_pic'] = this.designerProfilePic;
    data['img'] = this.img;
    data['full_pic'] = this.fullPic;
    data['flag'] = this.flag;
    data['designer_coutry'] = this.designerCoutry;
    data['designer_country_code'] = this.designerCountryCode;
    data['designer_country'] = this.designerCountry;
    data['theme'] = this.theme;
    return data;
  }
}