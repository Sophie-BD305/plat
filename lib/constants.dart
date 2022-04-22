import 'package:flutter/material.dart';

final String baseUrl =
    'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
const String API_KEY = 'YOUR_KEY';
const places = [
  {'id': '1', 'placeName': '베이커리'},
  {'id': '2', 'placeName': '레스토랑'},
  {'id': '3', 'placeName': '카페'}
];

class AppColor {
  static const kGrayScale1000 = Color(0xff000000);
  static const kGrayScale600 = Color(0xff6A6A6A);
  static const kGrayScale500 = Color(0xff858585);
  static const kGrayScale300 = Color(0xffC8C8C8);
  static const kGrayScale100 = Color(0xffE8E8E8);
  static const kGrayScale50 = Color(0xffF5F5F5);
  static const kGrayScale0 = Color(0xffEBFFFB);

  static const kJade600 = Color(0xff00CCA7);
  static const kJade500 = Color(0xff1EE0BD);
  static const kJade300 = Color(0xff74F2DC);
  static const kJade100 = Color(0xffC1FFF4);
  static const kJade50 = Color(0xffEBFFFB);
}

const kPrimaryColor = Color(0xff1EE0BD);
const kTextColor = Color(0xff3c4046);
const kBackgroundColor = Color(0xfff9f8fd);

const double kDefaultPadding = 16.0;
