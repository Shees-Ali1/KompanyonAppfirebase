import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/input_message2.dart';
import 'package:kompanyon_app/User%20Pathway/slider3.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway1.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';

import '../const/image.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'package:kompanyon_app/view/transition_screen/transition_one.dart'; // Import TransitionOne

class InputMessage1 extends StatefulWidget {
  @override
  _InputMessage1State createState() => _InputMessage1State();
}

class _InputMessage1State extends State<InputMessage1> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 186.h),
          Center(
            child: InterCustomText(
              text:  'Why are you exploring\nmindfulness practices?',
              textAlign: TextAlign.center,
              textColor: primaryColor,
              fontsize: 24.sp,
            ),
          ),
          SizedBox(height: 100.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child:  InputField(
              maxlines: 5,
              contentPadding:
              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              hint: 'Type your Answer here',
              keyboard: TextInputType.text,

            ),
          ),

          SizedBox(height: 61.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButton(
                height: 58.h,
                text: "Submit", onPressed: (){
              // Navigate to Slider1 with custom transition
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Slider3(),
                  transitionsBuilder: (context, animation, secondaryAnimation,
                      child) {
                    // Use your desired transition (slide and fade)
                    return FadeTransition(
                      opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
                      child: SlideTransition(
                        position: animation.drive(
                            Tween<Offset>(begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))),
                        child: child,
                      ),
                    );
                  },
                ),
              );
            }
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      TransitionOne(), // Your desired next screen
                  transitionsBuilder: (context, animation, secondaryAnimation,
                      child) {
                    // Use your desired transition (slide and fade)
                    return FadeTransition(
                      opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
                      child: SlideTransition(
                        position: animation.drive(
                            Tween<Offset>(begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))),
                        child: child,
                      ),
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image(
                  color: primaryColor,

                  image: AssetImage(AppImages.backarrow),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}