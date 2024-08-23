import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/view/Auth/signup_screen.dart';
import 'package:kompanyon_app/view/profile/account_settings.dart';
import 'package:kompanyon_app/view/profile/change_password.dart';
import 'package:kompanyon_app/view/profile/edit_profile.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:kompanyon_app/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _upSlideAnimation;
  late Animation<Offset> _slideAnimation;

  bool isselected = false;

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
    _upSlideAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    ));

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        title: SlideTransition(
            position: _upSlideAnimation,
            child: const InterCustomText(
              fontWeight: FontWeight.w600,
              fontsize: 26,
              text: 'My Profile',
              textColor: primaryColor,
            )),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: greyColor,
            thickness: 0.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            // key:
                            //   ValueKey<String>(_pickedImage?.path ?? 'default'),
                            // _pickedImage != null
                            //     ? FileImage(File(_pickedImage!.path))
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(AppImages.profilePic)
                                      as ImageProvider,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InterCustomText(
                              text: 'Leo Alston',
                              textColor: secondaryText,
                              fontWeight: FontWeight.w500,
                              fontsize: 20,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            InterCustomText(
                              text: 'leo.alston@example.com',
                              textColor: secondaryText,
                              fontWeight: FontWeight.w500,
                              fontsize: 14,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 12.h,
                // ),
                // GestureDetector(
                //   onTap: _selectImage,
                //   child: InterCustomText(
                //     text: 'Edit profile image',
                //     textColor: primaryColor,
                //   ),
                // ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InterCustomText(
                      text: 'My Account Information',
                      textColor: secondaryText,
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),

                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePassword()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 60.h,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InterCustomText(
                          fontsize: 16,
                          text: 'Change Password',
                          textColor: primaryColor,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: secondaryText,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 60.h,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InterCustomText(
                          fontsize: 16,
                          text: 'Edit Profile',
                          textColor: primaryColor,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: secondaryText,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InterCustomText(
                      text: 'Support',
                      textColor: secondaryText,
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountSettings()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InterCustomText(
                                fontsize: 16,
                                text: 'Account Settings',
                                textColor: primaryColor,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: secondaryText,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        height: 0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        decoration: BoxDecoration(color: backgroundColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isselected = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isselected
                                          ? primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.light_mode,
                                        color: isselected
                                            ? Colors.white
                                            : primaryText,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InterCustomText(
                                        text: 'Light',
                                        textColor: isselected
                                            ? Colors.white
                                            : primaryText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isselected = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: !isselected
                                          ? primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.dark_mode,
                                        color: !isselected
                                            ? Colors.white
                                            : primaryText,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InterCustomText(
                                        text: 'Dark',
                                        textColor: !isselected
                                            ? Colors.white
                                            : primaryText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                        position: _slideAnimation,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Container(
                            width: 90,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: secondarybackgroundColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: InterCustomText(
                              text: 'Log Out',
                              textColor: secondaryText,
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedField(
    String label,
    String hint,
    TextInputType keyboardType,
    FocusNode focusNode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InterCustomText(
            text: label,
            textColor: primaryColor,
            fontsize: 20.sp,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 10),
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: InputField(
              hint: hint,
              keyboard: keyboardType,
              focusNode: focusNode,
            ),
          ),
        ),
      ],
    );
  }
}
