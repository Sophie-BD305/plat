import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';

class NavBarButton extends StatefulWidget {
  const NavBarButton({
    Key? key,
    required this.title,
    required this.isActivate,
  }) : super(key: key);

  final String title;
  final bool isActivate;

  @override
  State<NavBarButton> createState() => NavBarButtonState();
}

class NavBarButtonState extends State<NavBarButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: widget.navigate,
      child: Column(
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: widget.isActivate == true
                  ? AppColor?.kJade500
                  : AppColor.kGrayScale0.withOpacity(0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          SvgPicture.asset(
            'assets/icons/feed.svg',
            color: widget.isActivate == true
                ? AppColor?.kJade500
                : AppColor.kGrayScale0,
            height: 18,
            width: 18,
          ),
          SizedBox(height: 8),
          Text(
            widget.title,
            style: TextStyle(
              color: widget.isActivate == true
                  ? AppColor?.kJade500
                  : AppColor.kGrayScale0,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
