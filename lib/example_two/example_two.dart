import 'package:flutter/material.dart';
import 'package:plat/components/nav_bar.dart';
import 'package:plat/example/components/body.dart';

class ExampleTwoScreen extends StatelessWidget {
  const ExampleTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapSample(),
      bottomNavigationBar: MyBottomNavbar(),
    );
  }
}
