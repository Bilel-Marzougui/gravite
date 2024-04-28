import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAll extends StatelessWidget {
  Color color ;
  Widget widget;
  Bindings binding;
  SeeAll(this.color,this.widget,this.binding);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Get.to(()=>widget,binding: binding),
      child: Container(
        height: 70,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.navigate_next,
                  color: color,
                  size: 20,
                ),
                Text("SEE ALL",
                    style: TextStyle(
                        color: color,
                        fontSize: 15,
                        decoration: TextDecoration.underline)),
              ],
            ),
            Divider(
              color: color,
              thickness: 6,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
