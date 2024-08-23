import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/input_message1.dart';
import 'package:kompanyon_app/User%20Pathway/slider3.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway5.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway7.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import '../clickable_wheel.dart';
import '../const/image.dart';
import '../widgets/custom_button.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';


class UserPathway6 extends StatefulWidget {
  const UserPathway6({super.key});

  @override
  _UserPathway6State createState() => _UserPathway6State();
}

class _UserPathway6State extends State<UserPathway6>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textAnimation;
  late Animation<Offset> _sliderAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _zoomAnimation;
  List<String> _selectedOptions = []; // Store selected options
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _sliderAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _zoomAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    final userpathway6 = [
      'Reading',
      'Audio Guided Sessions',
      'Video Demonstrations',
      'Interactive tools',
      'Group sessions',
    ];

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
                              builder: (context) => UserPathway5()));
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
                    'Question 6/10',
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
                    text: "Learning Style",
                    fontsize: 32.sp,
                    fontWeight: FontWeight.w500,
                    textColor: primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _textAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InterCustomText(
                      text:
                          'How do you prefer to engage with mindfulness content?',
                      textAlign: TextAlign.start,
                      textColor: secondaryText,
                      fontsize: 18.sp,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _zoomAnimation,
                    child: ListView.builder(
                      shrinkWrap: true, // Add this line
                      physics: NeverScrollableScrollPhysics(), // Add this line
                      itemCount: userpathway6.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0), // Add some spacing
                          child: Row(
                            children: [
                              Checkbox(
                                value: _selectedOptions.contains(userpathway6[index]),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      _selectedOptions.add(userpathway6[index]);
                                    } else {
                                      _selectedOptions.remove(userpathway6[index]);
                                    }
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(userpathway6[index],
                                    style: GoogleFonts.asul(
                                      letterSpacing: 0,
                                      color: primaryColor,
                                      fontSize: 16.sp,
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.0),
                child: CustomButton(
                  text: 'Next Question',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserPathway7()));
                  },
                  height: 52.h,
                ),
              ),
            ],
          ),
        ));
  }
}
