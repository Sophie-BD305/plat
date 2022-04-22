import 'package:flutter/material.dart';
import 'package:plat/components/nav_bar_button.dart';
import 'package:plat/example/example.dart';
import 'package:plat/example_two/example_two.dart';
import 'package:plat/home/home.dart';
import 'package:plat/map/map.dart';
import '../constants.dart';

var activatedTab = 0;

class MyBottomNavbar extends StatelessWidget {
  const MyBottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        top: kDefaultPadding,
      ),
      height: 104,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.kGrayScale1000.withOpacity(0),
            AppColor.kGrayScale1000
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
              activatedTab = 0;
            },
            child: NavBarButton(
              title: 'FEED',
              isActivate: activatedTab == 0 ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(),
                ),
              );
              activatedTab = 1;
            },
            child: NavBarButton(
              title: 'TRIP',
              isActivate: activatedTab == 1 ? true : false,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExampleScreen(),
                ),
              );
              activatedTab = 2;
            },
            child: NavBarButton(
              title: 'ME',
              isActivate: activatedTab == 2 ? true : false,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExampleTwoScreen(),
                ),
              );
              activatedTab = 3;
            },
            child: const Text('기타2'),
          ),
        ],
      ),
    );
  }
}
