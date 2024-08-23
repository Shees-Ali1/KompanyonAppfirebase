import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/slider3.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway4.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import '../clickable_wheel.dart';
import '../const/image.dart';
import '../widgets/custom_button.dart';
import 'user_pathway1.dart'; // Import the next screen
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPathway2 extends StatefulWidget {
  const UserPathway2({super.key});

  @override
  _UserPathway2State createState() => _UserPathway2State();
}

class _UserPathway2State extends State<UserPathway2>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _imageController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _zoomAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _imageFadeAnimation;
  late Animation<double> _imageScaleAnimation;
  final PageController pageController=PageController();

  List<String> _selectedOptions = []; // Store selected options

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
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

    _imageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));



    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _imageController, curve: Curves.easeIn));

    _imageScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _imageController, curve: Curves.elasticOut));

    _controller.forward();
    _imageController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userpathway3 = [
      'Never',
      'Rarely',
      'Sometimes',
      'Often',
      'Daily',
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
                    // Navigator.pop(context);
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
                  'Question 2/10',
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
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InterCustomText(
                    text: "Mindfulness Interest",
                    fontsize: 32.sp,
                    fontWeight: FontWeight.w500,
                    textColor: primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),

            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InterCustomText(
                      text: 'How often do you currently practice mindfulness or meditation',

                      textColor: secondaryText,
                      fontsize: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _zoomAnimation,
                  child: ListView.builder(
                    shrinkWrap: true, // Add this line
                    physics: NeverScrollableScrollPhysics(), // Add this line
                    itemCount: userpathway3.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0), // Add some spacing
                        child: Row(
                          children: [
                            Checkbox(
                              value: _selectedOptions.contains(userpathway3[index]),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    _selectedOptions.add(userpathway3[index]);
                                  } else {
                                    _selectedOptions.remove(userpathway3[index]);
                                  }
                                });
                              },
                            ),
                            Expanded(
                              child: Text(userpathway3[index],
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
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 44.0),
              child: CustomButton(
                text: 'Next Question',
                onPressed: () {  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Slider3()

                    ))
                ;
                },
                height: 52.h,

              ),
            ),

          ],
        ),
      ),
    );
  }
}
