import 'package:flutter/material.dart';
import 'package:plat/components/nav_bar.dart';
import 'package:plat/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: MyBottomNavbar(),
    );
  }
}
