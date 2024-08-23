import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/input_message1.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway2.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway4.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway5.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../const/image.dart';

class Slider3 extends StatefulWidget {
  @override
  _Slider3State createState() => _Slider3State();
}

class _Slider3State extends State<Slider3> {
  double _sliderValue = 1; // Initial value for the slider


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserPathway2()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InterCustomText(
                  text: "Pathway Assessment",
                  textColor: primaryColor,
                  fontsize: 30.sp,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                  child: Text(
                    'Question 3/10',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      letterSpacing: 0,
                      color: secondaryText,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              LinearPercentIndicator(
                lineHeight: 12,
                barRadius: Radius.circular(12),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InterCustomText(
                    text: "Mindfulness Knowledge",
                    fontsize: 32.sp,
                    fontWeight: FontWeight.w500,
                    textColor: primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InterCustomText(
                  text:
                      'How would you rate your current knowledge of mindfulness on a scale from 1 (beginner) to 5 (expert)?',
                  textAlign: TextAlign.left,
                  fontsize: 18.sp,
                  textColor: secondaryText,
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                child: Slider(
                  activeColor: primaryColor,
                  inactiveColor: Colors.white,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  value: _sliderValue, // Use the state variable
                  onChanged: (double value) {
                    setState(() {
                      _sliderValue =
                          value; // Update the state when slider changes
                    });
                  },
                ),
              ),

              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: CustomButton(
                    height: 58.h,
                    text: "Next Question",
                    onPressed: () {
                      // Navigate to UserPathway4 with custom transition
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  UserPathway4(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            // Use your desired transition (slide and fade)
                            return FadeTransition(
                              opacity:
                                  animation.drive(Tween(begin: 0.0, end: 1.0)),
                              child: SlideTransition(
                                position: animation.drive(Tween<Offset>(
                                    begin: const Offset(-1.0, 0.0),
                                    end: const Offset(0.0, 0.0))),
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
