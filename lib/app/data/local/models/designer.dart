class Designer {
  String id;
  String profilePic;
  String bannerPic;
  String profilePicBig;
  int followers;
  int isFollower;
  int designs;
  String designer;
  String flag;
  String designerCoutry;
  SocialNetworks socialNetworks;
  String countryName;
  List<String> gallery;
  int galleryCount;

  Designer({this.id, this.profilePic, this.bannerPic, this.profilePicBig, this.followers, this.isFollower, this.designs, this.designer, this.flag, this.designerCoutry, this.socialNetworks, this.countryName, this.gallery, this.galleryCount});

  Designer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePic = json['profile_pic'];
    bannerPic = json['banner_pic'];
    profilePicBig = json['profile_pic_big'];
    followers = json['followers'];
    isFollower = json['is_follower'];
    designs = json['designs'];
    designer = json['designer'];
    flag = json['flag'];
    designerCoutry = json['designer_coutry'];
    socialNetworks = json['social_networks'] != null ? new SocialNetworks.fromJson(json['social_networks']) : null;
    countryName = json['country_name'];
    gallery = json['gallery'].cast<String>();
    galleryCount = json['gallery_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_pic'] = this.profilePic;
    data['banner_pic'] = this.bannerPic;
    data['profile_pic_big'] = this.profilePicBig;
    data['followers'] = this.followers;
    data['is_follower'] = this.isFollower;
    data['designs'] = this.designs;
    data['designer'] = this.designer;
    data['flag'] = this.flag;
    data['designer_coutry'] = this.designerCoutry;
    if (this.socialNetworks != null) {
      data['social_networks'] = this.socialNetworks.toJson();
    }
    data['country_name'] = this.countryName;
    data['gallery'] = this.gallery;
    data['gallery_count'] = this.galleryCount;
    return data;
  }
}

class SocialNetworks {
SocialNetworks.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}