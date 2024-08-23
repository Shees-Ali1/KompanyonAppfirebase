import 'package:flutter/material.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathwayBegin.dart';
import 'package:kompanyon_app/clickable_wheel.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/reflection/reflection.dart';
import 'package:kompanyon_app/view/Leadership_screens/Leadership.dart';
import 'package:kompanyon_app/view/home_screen/components/hear_screen.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/widgets/custom_textContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenTitles = [
      'Hear',
      'Learn',
      'Your Pathway',
      'Read',
      'Connect',
      'Help',
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 86.h,
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.only(left: 73.w, right: 86.w),
                child: InterCustomText(
                  textAlign: TextAlign.center,
                  text:
                  'Eventually this will be a dashboard, but for now we can plug-in words of affirmation',
                  textColor: primaryColor,
                  fontsize: 24.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: ClickableWheel(
                  titles: homeScreenTitles,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
