import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/input_message1.dart';
import 'package:kompanyon_app/User%20Pathway/slider3.dart';
import 'package:kompanyon_app/User%20Pathway/slider8.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import '../clickable_wheel.dart';
import '../const/image.dart';

class UserPathway9 extends StatefulWidget {
  const UserPathway9({super.key});

  @override
  _UserPathway9State createState() => _UserPathway9State();
}

class _UserPathway9State extends State<UserPathway9> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeIn)
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );
  }

  @override
  Widget build(BuildContext context) {
    final userpathway8 = [
      'Yes',
      'No',
      'Maybe',
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Slider8() ));

            },
            child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                  size: 45,
                )),
          ),
          SizedBox(
            height: 60.h,
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Align(
              alignment: Alignment.center,
              child: InterCustomText(
                text:  'Would you be interested in\n connecting with a community\n or group as part of your\n mindfulness journey?',
                textAlign: TextAlign.center,
                textColor: primaryColor,
                fontsize: 24.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: ClickableWheel(titles: userpathway8),
            ),
          ),

        ],
      ),
    );
  }


}
