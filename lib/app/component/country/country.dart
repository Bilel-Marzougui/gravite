import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';
class Country extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.3,
        width: Get.width,
        margin: EdgeInsets.only(bottom: 10),
        child: CountryListView(
          flagWidth: 30,
          flagHeight: 30,
          itemTitleStyle: TextStyle(fontSize: 15),
          itemBuilder: (context, int, country) {
            return InkWell(
              onTap: (){
                print(country.code);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: Get.width*0.3,),
                    Image(
                      height: 25,
                      width: 40,
                      image: new AssetImage(
                        country.flagUri,
                        package: 'ola_like_country_picker',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      country.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
