import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graviitee/app/modules/cart/bindings/cart_binding.dart';
import 'package:graviitee/app/modules/cart/views/cart_view.dart';
import 'package:graviitee/app/modules/favorite/bindings/favorite_binding.dart';
import 'package:graviitee/app/modules/favorite/views/favorite_view.dart';
import 'package:graviitee/app/modules/home/bindings/home_binding.dart';
import 'package:graviitee/app/modules/home/views/home_view.dart';
import 'package:graviitee/app/modules/login/bindings/login_binding.dart';
import 'package:graviitee/app/modules/login/views/login_view.dart';
import 'package:graviitee/app/modules/term_of_use/bindings/term_of_use_binding.dart';
import 'package:graviitee/app/modules/term_of_use/views/term_of_use_view.dart';
import 'package:graviitee/app/modules/try_design/controllers/try_design_controller.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TryDesignController tryDesignController = Get.put(TryDesignController());

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(icon: Icons.home, text: 'Home', onTap: () => Get.to(() => HomeView(),binding: HomeBinding())),
          _createDrawerItem(icon: Icons.card_travel, text: 'Cart', onTap: () => Get.to(() => CartView(),binding: CartBinding())),
          _createDrawerItem(icon: Icons.person_pin, text: 'MyGrav', onTap: () => Get.to(() => FavoriteView(),binding: FavoriteBinding())),
          Container(
            color: Colors.grey[200],
            child: _createDrawerItem(
                icon: Icons.help_outline, text: 'Help', onTap: () => print(""),isd:false),
          ),
          Container(
            color: Colors.grey[200],

            child: _createDrawerItem(

                icon: Icons.support,
                text: 'Support',
                onTap: () => print(""),isd:false),
          ),
          Container(
            color: Colors.grey[200],

            child: _createDrawerItem(
                icon: Icons.cleaning_services_rounded, text: 'Clear cache', onTap: () => print(""),isd:false),
          ),
          SizedBox(height: 15,),

          _createDrawerItem(icon: Icons.share_rounded, text: 'Share app', onTap: () => tryDesignController.share(),),
          _createDrawerItem(icon: Icons.feedback, text: 'App Feedback', onTap: () => print(""),isd: false),
          SizedBox(height: 15,),
          Container(
            color: Colors.grey[200],
            child: _createDrawerItem(
                icon: Icons.policy, text: 'Terms Policies-Privacy', onTap: () => Get.to(() => TermOfUseView(),binding: TermOfUseBinding())),
          ),
          Container(
            color: Colors.grey[200],

            child: _createDrawerItem(

                icon: Icons.account_balance_wallet_outlined,
                text: 'About us',
                onTap: () => print(""),isd:false),
          ),
          Container(
            color: Colors.grey[200],

            child: _createDrawerItem(
                icon: Icons.logout, text: 'Log Out', onTap: (){
              final box = GetStorage();
              box.remove('customer_id');
              Get.to(()=>LoginView(),binding: LoginBinding());

            },isd:false),
          ),

        ],
      ),
    );
  }

  Widget _createHeader() {
    var box = GetStorage();
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: Color(0xff067882)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                child: Icon(Icons.person,size: 55,color: Color(0xffb4b2b2),),
                backgroundColor: Color(0xffeeeeee),
              ),
              SizedBox(height: 16,),
              Text(box.read('username'),style: TextStyle(color:Color(0xffeeeeee),letterSpacing: 2 ),)
            ]));
  }

  Widget _createDrawerItem(
      { IconData icon,
       String text,
       GestureTapCallback onTap,
      isd = true,
      }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon,color: Colors.grey,),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(left:2.0),
                  child: Text(text),
                ),
                Spacer(),
                Icon(Icons.navigate_next_outlined,color: Colors.grey[300],),
                SizedBox(width: 10,)

              ],
            ),
            isd == true ?  Divider(indent: 20,color: Colors.grey[300],):SizedBox(height:1,)
          ],
        ),
      ),
    );


  }
}
