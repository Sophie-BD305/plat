import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plat/constants.dart';
import 'package:what3words/what3words.dart';

var api = What3WordsV3('MABA5QIB');

class Body extends StatelessWidget {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void searchlocation() async {
    var words = await api
        .convertTo3wa(Coordinates(51.508344, -0.12549900))
        .language('ko')
        .execute();
    print('Words: ${words.data()?.toJson()}');
  }

  void findlocation() async {
    var coordinates =
        await api.convertToCoordinates('index.home.raft').execute();

    if (coordinates.isSuccessful()) {
      print('Coordinates ${coordinates.data()!.toJson()}');
    } else {
      var error = coordinates.error();

      if (error == What3WordsError.BAD_WORDS) {
        // The three word address provided is invalid
        print('BadWords: ${error?.message}');
      } else if (error == What3WordsError.INTERNAL_SERVER_ERROR) {
        // Server Error
        print('InternalServerError: ${error?.message}');
      } else if (error == What3WordsError.NETWORK_ERROR) {
        // Network Error
        print('NetworkError: ${error?.message}');
      } else {
        print('${error?.code} : ${error?.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 80),
        child: SafeArea(
          child: Container(
            height: 80,
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              height: 38,
              width: 133,
            ),
            // backgroundColor: AppColor.kGrayScale1000.withOpacity(0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.kGrayScale1000,
                  AppColor.kGrayScale1000.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                firebaseFirestore
                    .collection('profile')
                    .doc('123123')
                    .set({'ryan': '123'});
              },
              child: const Text('제발 돼라!!!!!'),
            ),
            TextButton(
              onPressed: () {
                searchlocation();
              },
              child: const Text('이건?'),
            ),
          ],
        ),
      ),
    );
  }
}
