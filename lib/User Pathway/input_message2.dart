import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/slider8.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway7.dart';
import 'package:kompanyon_app/const/color.dart';

import '../const/image.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_inter_text.dart';
import '../widgets/custom_textfield.dart';

class InputMessage2 extends StatefulWidget {
  @override
  _InputMessage2State createState() => _InputMessage2State();
}

class _InputMessage2State extends State<InputMessage2> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false, // Disable resizing to avoid bottom inset
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserPathway7() ));

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: InterCustomText(
                  text: 'Are there specific topics or areas you are particularly interested in exploring?',
                  textColor: primaryColor,
                  fontsize: 24.sp,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 100.h),
            Expanded( // Use Expanded to make the input field take remaining space
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: const SingleChildScrollView( // Allow scrolling for the input field
                  child: InputField(
                    maxlines: 5,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hint: 'Type your response here',
                    keyboard: TextInputType.text,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                height: 58.h,
                text: "Submit",
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Slider8(),
                      transitionsBuilder: (context, animation, secondaryAnimation,
                          child) {
                        // Slide and fade transition for Slider2
                        final slideAnimation = Tween<Offset>(
                          begin: const Offset(1.0, 0.0), // Slide from the right
                          end: Offset.zero,
                        ).animate(animation);

                        final fadeAnimation = Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(animation);

                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: SlideTransition(
                            position: slideAnimation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 60.h), // Add some space before the back button

          ],
        ),
      ),
    );
  }
}
