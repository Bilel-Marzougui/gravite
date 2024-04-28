import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class SocialMediaIconBtn extends StatelessWidget {
  final String icon;
  final String socialLink;
  final double height;
  final double horizontalPadding;

  SocialMediaIconBtn(
      { this.icon, this.socialLink,  this.height,  this.horizontalPadding});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () async => await launch(socialLink),
        child: Image.network(
          icon,
          height: 20,

        ),
      ),
    );
  }
}