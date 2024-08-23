import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/view/home_screen/home_screen.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import '../clickable_wheel.dart';
import '../const/image.dart';
import '../view/transition_screen/transition_three.dart';

class UserPathway10 extends StatefulWidget {
  const UserPathway10({super.key});

  @override
  _UserPathway10State createState() => _UserPathway10State();
}

class _UserPathway10State extends State<UserPathway10> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
        .animate(_controller);

    _controller.forward();

  }



  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: 0.0, end: 1.0);
        var fadeAnimation = animation.drive(tween);
        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userpathway9 = [
      'Focus & Productivity',
      "Burnout Reduction",
      "Performance",
      'Collaboration',
      'Leadership',
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SlideTransition(
        position: _slideAnimation,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
              Align(
                alignment: Alignment.center,
                child: InterCustomText(
                  text: 'Please select your new \npathway to get started on\n your journey',
                  textAlign: TextAlign.center,
                  textColor: primaryColor,
                  fontsize: 24.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ClickableWheel(titles: userpathway9),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
