import 'package:flutter/material.dart';
import 'package:plat/components/nav_bar.dart';
import 'package:plat/map/components/body.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: MyBottomNavbar(),
    );
  }
}
