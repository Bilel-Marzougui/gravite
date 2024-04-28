import 'package:carousel_slider/carousel_slider.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CarouselSlider.builder(
          itemCount: 3,
          itemBuilder:
              (BuildContext context, int itemIndex, int i) =>
              FadeShimmer(
                baseColor: Colors.grey[400],
                highlightColor: Colors.grey[200],
                height: 90,
                width: 110,
                millisecondsDelay: 5000,
              ),
          options: CarouselOptions(
              disableCenter: false,
              height: 110,
              aspectRatio: 0.3,
              viewportFraction: 0.33,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 5),
              enlargeCenterPage: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration:
              Duration(milliseconds: 800),
              enableInfiniteScroll: true),
        ));
  }
}
