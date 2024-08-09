import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class banners extends StatefulWidget {
  const banners({super.key});

  @override
  State<banners> createState() => _bannersState();
}

class _bannersState extends State<banners> {
  final myitems = [
    Image.asset('assets/images/banner-1.png'),
    Image.asset('assets/images/banner-2.png'),
    Image.asset('assets/images/banner-3.png')
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CarouselSlider(
        //   options: CarouselOptions(
        //       autoPlay: true,
        //       height: 250,
        //       autoPlayCurve: Curves.fastOutSlowIn,
        //       autoPlayAnimationDuration: const Duration(milliseconds: 800),
        //       autoPlayInterval: const Duration(seconds: 5),
        //       enlargeCenterPage: true,
        //       aspectRatio: 2.0,
        //       onPageChanged: (index, reson) {
        //         setState(() {
        //           myCurrentIndex = index;
        //         });
        //       }),
        //   items: myitems,
        // ),

        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/banner-1.png'),
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        AnimatedSmoothIndicator(
          activeIndex: myCurrentIndex,
          count: myitems.length,
          effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 10,
              dotColor: Color(0xffFFD300),
              activeDotColor: Color(0xffE10636),
              paintStyle: PaintingStyle.fill),
        )
      ],
    );
  }
}
