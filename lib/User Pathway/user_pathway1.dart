import 'package:flutter/material.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/text_only.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway2.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathwayBegin.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import '../clickable_wheel.dart';
import '../const/image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../widgets/custom_textfield.dart';

class UserPathway1 extends StatefulWidget {
  const UserPathway1({super.key});

  @override
  _UserPathway1State createState() => _UserPathway1State();
}

class _UserPathway1State extends State<UserPathway1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _zoomAnimation;
  final PageController pageController=PageController();

  List<String> _selectedOptions = []; // Store selected options
 List<Map<String,dynamic>> assessments=[
   {
     "topic":"Mindfulness Interest",
     "question": "Why are you exploring mindfulness practices? \nSelect all that apply",
      "options": [
        'Stress Relief',
        'Improve Mental Health',
        'Curiosity',
        'Improve Relationships',
        'Other (please specify)',
      ],
     "isMessage":false,
    },
   {
     "topic":"Mindfulness Interest",
     "question": 'How often do you currently practice mindfulness?',
      "options": [
        'Never',
        'Rarely',
        'Sometimes',
        'Often',
        'Daily',
      ],
     "isMessage":false,

    },
   {
     "topic":"Mindfulness Knowledge",
     "question":  'How would you rate your current knowledge of mindfulness on a scale from 1 (beginner) to 5 (expert)',
     "options": [

     ],
     "isMessage":false,

   },
   {
     "topic":"Mindfulness Interest",
     "question":  'What challenges or obstacles do you face when trying to practice mindfulness?  ',
     "options": [
       "Don't know how to start",
       'Lack of time',
       'Easily distracted',
       'Not seeing results',
       "Not Effective",
     ],
     "isMessage":false,

   },
   {
     "topic":"Mindfulness Interest",
     "question":  'Which of the following would you find most helpful in your mindfulness journey?',
     "options": [
       'Guided meditation',
       'Tracking tools',
       'Community Support',
       'Experts insights',
       'Daily reminders',
     ],
     "isMessage":false,

   },
   {
     "topic":"Learning Style",
     "question":  'How do you prefer to engage with mindfulness content?',
     "options": [
       'Reading',
       'Audio Guided Sessions',
       'Video Demonstrations',
       'Interactive tools',
       'Group sessions',
     ],
     "isMessage":false,

   },
   {
     "topic":"Learning Style",
     "question":    'Do you prefer short daily practices or longer, less frequent sessions?',
     "options": [
       'Short Daily Practices',
       'Longer Sessions ',
       'A Mix or Both',
     ],
     "isMessage":false,

   },
   {
     "topic":"Learning Style",
     "question":  'On a scale from 1 (very low) to 5 (very high), how would you rate your current stress level? ',
     "options": [

     ],
     "isMessage":false,

   },
   {
     "topic":"Learning Style",
     "question": 'Would you be interested in connecting with a community or group as part of your mindfulness journey?',
     "options": [
       // 'Yes',
       // 'No',
       // 'Maybe',
     ],
     "isMessage":true,

   },
   {
     "topic":"Learning Style",
     "question":'Please select your new pathway to get started on your journey',

   "options": [
     'Focus & Productivity',
     "Burnout Reduction",
     "Performance",
     'Collaboration',
     'Leadership',
     ],
     "isMessage":false,

   },

  ];

int _currentPage=0;
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
    _zoomAnimation = Tween<double>(
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
    pageController.dispose();
  }
  double _sliderValue = 1; // Initial value for the slider


  @override
  Widget build(BuildContext context) {
    final userpathway2 = [
      'Stress Relief',
      'Improve Mental Health',
      'Curiosity',
      'Improve Relationships',
      'Other (please specify)',
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  if(_currentPage<=0){
                    Navigator.pop(context);
                  }else {
                    pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }

                },
                child: Icon(Icons.arrow_back,size: 30,),
              ),
            ),
            SizedBox(width: 10,),
            InterCustomText(
              text: "Pathway Assessment", textColor: primaryColor,
              fontsize: 32.sp,textAlign: TextAlign.left,

            ),
          ],),
        ),

        automaticallyImplyLeading: false,

        backgroundColor: backgroundColor,
      ),
      body: GestureDetector(
        onTap: () { FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                    child: Text(
                      'Question ${_currentPage + 1}/${assessments.length}', // Display current question number
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
                  progressColor: primaryColor,
                  barRadius: Radius.circular(12),
                  percent: (_currentPage + 1) / assessments.length, // Update progress
          
                ),
                SizedBox(
                  height: 40.h,
                ),
             Container(
               // color: Colors.red,
               height: 500.h,
               child: PageView.builder(
                 controller: pageController,
                   itemCount: assessments.length,
                   onPageChanged: (index) {
                     setState(() {
                       _currentPage = index; // Update current page index
                     });
                   },
                   itemBuilder: (context,index){
                     final assess=assessments[index];
                 return    Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     FadeTransition(
                       opacity: _fadeAnimation,
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                         child: Align(
                           alignment: Alignment.centerLeft,
                           child: InterCustomText(
                             text: assess['topic'],
                             fontsize: 30.sp,
                             fontWeight: FontWeight.w500,
                             textColor: primaryColor,
                           ),
                         ),
                       ),
                     ),
                     SizedBox(height: 10),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                       child: InterCustomText(
                         text:assess['question'],
          
                         textColor: secondaryText,
                         fontsize: 18.sp,
                       ),
                     ),
                     SizedBox(height: 10),
                     Expanded(
                       child: FadeTransition(
                         opacity: _fadeAnimation,
                         child: ScaleTransition(
                           scale: _zoomAnimation,
                           child:assess['options'].toList().isNotEmpty? ListView.builder(
                             shrinkWrap: true, // Add this line
                             physics: NeverScrollableScrollPhysics(), // Add this line
                             itemCount: assess['options'].length,
                             itemBuilder: (context, index) {
                               return Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 5.0), // Add some spacing
                                 child: Row(
                                   children: [
                                     Checkbox(
          
          
                                       value: _selectedOptions.contains(assess['options'][index]),
                                       // fillColor: WidgetStatePropertyAll(primaryColor),
                                       activeColor: primaryColor,
                                       onChanged: (bool? value) {
                                         setState(() {
                                           if (value!) {
                                             _selectedOptions.add(assess['options'][index]);
                                           } else {
                                             _selectedOptions.remove(assess['options'][index]);
                                           }
                                         });
                                       },
                                     ),
                                     Expanded(
                                       child: Text(assess['options'][index],
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
                           ):assess['isMessage']==false?Slider(
          
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
                           ):   Container(
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                             child:  InputField(
                               maxlines: 3,
                               contentPadding:
                               EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                               hint: 'Type your Answer here',
                               keyboard: TextInputType.text,
          
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 );
               }),
             ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.0),
                  child: CustomButton(

                    text: _currentPage == assessments.length - 1
                        ? 'Finish'
                        : 'Next Question', // Update button text
                    onPressed: () {
                      if (_currentPage < assessments.length - 1) {
                        pageController.animateToPage(
                          _currentPage + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
          
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TextOnly()));
                      }
                    },
                    height: 62.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}