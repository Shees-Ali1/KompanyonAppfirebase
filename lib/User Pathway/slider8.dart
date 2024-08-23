import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/User%20Pathway/input_message1.dart';
import 'package:kompanyon_app/User%20Pathway/input_message2.dart';
import 'package:kompanyon_app/User%20Pathway/user-pathway10.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway2.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway4.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway9.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';

import '../const/image.dart';
import 'package:kompanyon_app/view/transition_screen/transition_one.dart'; // Import TransitionOne

class Slider8 extends StatefulWidget {
  @override
  _Slider8State createState() => _Slider8State();
}

class _Slider8State extends State<Slider8> {
  int _selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InputMessage2() ));

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
          InterCustomText(text: 'On a scale from 1 (very low)\n to 5 (very high), how would\n you rate your current stress\n level? ',
            textAlign: TextAlign.center,
            fontsize:24.sp, textColor: primaryColor,
          ),
          SizedBox(height: 130.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Number 1
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNumber = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedNumber == 1 ? Color.fromRGBO(197, 211, 223, 1) : Colors.grey[200],
                    ),
                    child: Text('1', style: TextStyle(fontSize: 18)),
                  ),
                ),

                // Line
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),

                // Number 2
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNumber = 2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedNumber == 2 ?Color.fromRGBO(197, 211, 223, 1) : Colors.grey[200],
                    ),
                    child: Text('2', style: TextStyle(fontSize: 18)),
                  ),
                ),

                // Line
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),

                // Number 3
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNumber = 3;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedNumber == 3 ? Color.fromRGBO(197, 211, 223, 1) : Colors.grey[200],
                    ),
                    child: Text('3', style: TextStyle(fontSize: 18)),
                  ),
                ),

                // Line
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),

                // Number 4
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNumber = 4;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedNumber == 4 ? Color.fromRGBO(197, 211, 223, 1) : Colors.grey[200],
                    ),
                    child: Text('4', style: TextStyle(fontSize: 18)),
                  ),
                ),

                // Line
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),

                // Number 5
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNumber = 5;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedNumber == 5 ? Color.fromRGBO(197, 211, 223, 1) : Colors.grey[200],
                    ),
                    child: Text('5', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),

          // ? RGB 75, 121, 170
          // ! RGB 105, 127, 1215
          //  197, 211, 223  using currently

          SizedBox(height: 60.h,),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: CustomButton(
                height: 58.h,
                text: "Submit", onPressed: (){
              // Navigate to UserPathway4 with custom transition
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UserPathway9(),
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

        ],
      ),
    );
  }
}


//: