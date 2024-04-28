import 'package:graviitee/app/data/remote/Api_request.dart';



class SignupService {
  static SignupService _instance;

  static SignupService getInstance() {
    if (_instance == null)
      _instance = SignupService();
    return _instance;
  }

  Future signup(data,{Function onSuccess,  Function onError}) async {
    try {
      String url = "http://graviitee.net/dev/mobileapiv2/customer/register/";
      print(url);
      var response = await ApiRequest(
        url: url,
        data: data,
      ).post();
      onSuccess(response);
    } catch (e) {
      onError(e);
    }
  }



}