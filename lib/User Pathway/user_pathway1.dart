import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kompanyon_app/User%20Pathway/text_only.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widgets/custom_textfield.dart';
import '../const/color.dart';

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
  final PageController pageController = PageController();

  List<String> _selectedOptions = [];
  List<Map<String, dynamic>> assessments = [];

  int _currentPage = 0;

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
    _fetchAssessments();
  }

  Future<void> _fetchAssessments() async {
    try {
      CollectionReference assessmentsRef =
      FirebaseFirestore.instance.collection('assessments');
      QuerySnapshot snapshot = await assessmentsRef.get();

      setState(() {
        assessments =
            snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print('Error fetching assessments: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    pageController.dispose();
  }

  double _sliderValue = 1;

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
                    if (_currentPage <= 0) {
                      Navigator.pop(context);
                    } else {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 10),
              InterCustomText(
                text: "Pathway Assessment",
                textColor: primaryColor,
                fontsize: 32.sp,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (assessments.isEmpty)
                  Center(child: CircularProgressIndicator())
                else ...[
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                      child: Text(
                        'Question ${_currentPage + 1}/${assessments.length}',
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
                    percent:
                    (_currentPage + 1) / assessments.length,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    height: 500.h,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: assessments.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index; // Update current page index
                          });
                        },

                        itemBuilder: (context, index) {
                          final assess = assessments[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: InterCustomText(
                                  text: assess['question'],
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
                                    child: assess['options'].isNotEmpty
                                        ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: assess['options'].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: _selectedOptions
                                                    .contains(assess[
                                                'options'][index]),
                                                activeColor: primaryColor,
                                                onChanged:
                                                    (bool? value) {
                                                  setState(() {
                                                    if (value!) {
                                                      _selectedOptions.add(
                                                          assess['options']
                                                          [index]);
                                                    } else {
                                                      _selectedOptions
                                                          .remove(assess[
                                                      'options']
                                                      [index]);
                                                    }
                                                  });
                                                },
                                              ),
                                              Expanded(
                                                child: Text(
                                                    assess['options']
                                                    [index],
                                                    style: GoogleFonts
                                                        .asul(
                                                      letterSpacing: 0,
                                                      color: primaryColor,
                                                      fontSize: 16.sp,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                        : assess['isMessage'] == false
                                        ? Slider(
                                      activeColor: primaryColor,
                                      inactiveColor: Colors.white,
                                      min: 1,
                                      max: 5,
                                      divisions: 4,
                                      value: _sliderValue,
                                      onChanged: (double value) {
                                        setState(() {
                                          _sliderValue = value;
                                        });
                                      },
                                    )
                                        : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 30),
                                      child: InputField(
                                        maxlines: 3,
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10),
                                        hint:
                                        'Type your Answer here',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
