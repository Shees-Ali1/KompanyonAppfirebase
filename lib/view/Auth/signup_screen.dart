import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/controller/login_controller.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controller/signup_contoller.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  // Controllers for text fields
  final SignupController signupController =
      Get.put(SignupController()); // Initialize the controller
  final LoginController loginController =
      Get.put(LoginController()); // Initialize the controller

  // Focus nodes for text fields
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _retypePasswordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  late AnimationController _controller;
  bool _isLogoInFinalPosition = false;
  late final Animation<double> _scaleAnimation;
  bool ishowcontent = false;
  String? selectedRole;
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 2.0, end: 1.0).animate(_controller);

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _isLogoInFinalPosition = true;
      });
      _controller.forward().then((value) {
        setState(() {
          ishowcontent = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _retypePasswordFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () {
          // Unfocus all text fields when tapping outside
          _emailFocusNode.unfocus();
          _passwordFocusNode.unfocus();
          _retypePasswordFocusNode.unfocus();
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (ishowcontent == false)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                top: _isLogoInFinalPosition
                    ? Get.height * .13
                    : (Get.height / 2) - 37,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Center(
                    child: Center(
                        child: Image.asset(
                      AppImages.bglogo,
                      height: 60,
                      width: 60,
                    )),
                  ),
                ),
              ),
            if (ishowcontent)
              SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.w),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 160.h),
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.anchor,
                                size: 25, // Adjust the size as needed
                                color:
                                    primaryColor // Adjust the color as needed
                                ),
                            SizedBox(
                              width: 10.w,
                            ),
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: InterCustomText(
                                text: 'Kompanyon',
                                textColor: primaryColor,
                                fontsize: 30.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        InterCustomText(
                          text: 'Welcome',
                          textColor: primaryColor,
                          fontsize: 24.sp,
                        ),
                        SizedBox(height: 3.h),
                        InterCustomText(
                          textAlign: TextAlign.center,
                          text: 'Access your account or create a new one below',
                          textColor: primaryColor,
                          fontsize: 14.sp,
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle the onTap event to set isselected
                                setState(() {
                                  signupController.isselectedsignup.value =
                                      "Signup";
                                });
                              },
                              child: Container(
                                width: 90,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: signupController.isselectedsignup ==
                                          "Signup"
                                      ? primaryColor
                                      : Colors
                                          .white, // Change color based on isselected
                                ),
                                child: Center(
                                  child: InterCustomText(
                                    textAlign: TextAlign.center,
                                    text: 'Sign up',
                                    textColor:
                                        signupController.isselectedsignup ==
                                                "Signup"
                                            ? Colors.white
                                            : primaryColor,
                                    fontsize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: () {
                                // Handle the onTap event to set isselected to false
                                setState(() {
                                  signupController.isselectedsignup.value =
                                      "Signin";
                                });
                              },
                              child: Container(
                                width: 90,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: signupController.isselectedsignup ==
                                          "Signin"
                                      ? primaryColor
                                      : Colors
                                          .white, // Change color based on isselected
                                ),
                                child: Center(
                                  child: InterCustomText(
                                    textAlign: TextAlign.center,
                                    text: 'Sign in',
                                    textColor:
                                        signupController.isselectedsignup ==
                                                "Signin"
                                            ? Colors.white
                                            : primaryColor,
                                    fontsize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        signupController.isselectedsignup == "Signup"
                            ? Column(
                                children: [
                                  Container(
                                    key: ValueKey<String>(
                                        _pickedImage?.path ?? 'default'),
                                    width: 100.w,
                                    height: 120.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: primaryColor, width: 3),
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: _pickedImage != null
                                          ? DecorationImage(
                                              image: FileImage(
                                                  File(_pickedImage!.path)),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: _pickedImage == null
                                        ? Center(
                                            child: IconButton(
                                              icon:
                                                  const Icon(Icons.add_a_photo),
                                              color: primaryColor,
                                              onPressed: () {
                                                _selectImage();
                                              },
                                            ),
                                          )
                                        : null, // No child when _pickedImage is not null
                                  ),
                                  SizedBox(height: 10.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Name',
                                    keyboard: TextInputType.name,
                                    controller: signupController.nameController,
                                    focusNode:
                                        _nameFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Email',
                                    keyboard: TextInputType.emailAddress,
                                    controller:
                                        signupController.emailController,
                                    focusNode:
                                        _emailFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 10.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: containerBorder,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                    ),
                                    hint: const InterCustomText(
                                      text: '[role]',
                                      textColor: primaryColor,
                                    ),
                                    // Placeholder text
                                    value: selectedRole,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedRole = newValue;
                                      });
                                    },
                                    items: <String>['Admin', 'User', 'Guest']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: InterCustomText(
                                          text: value,
                                          textColor: primaryColor,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 24.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Password',
                                    keyboard: TextInputType.text,
                                    controller:
                                        signupController.passwordController,
                                    focusNode:
                                        _passwordFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Confirm Password',
                                    keyboard: TextInputType.text,
                                    controller:
                                        signupController.retypasswordController,
                                    focusNode:
                                        _retypePasswordFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomButton(
                                      text: 'Create Account',
                                      onPressed: () {
                                        signupController.handleSignUp();
                                        print('Create Account button pressed');
                                      },
                                      width: 327,
                                      height: 52,
                                      borderRadius: 12,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              )
                            : Column(
                                children: [
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Email',
                                    keyboard: TextInputType.text,
                                    controller:
                                        loginController.emailController1,
                                    focusNode:
                                        _emailFocusNode, // Added focusNode
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Password',
                                    keyboard: TextInputType.text,
                                    controller:
                                        loginController.passwordController1,
                                    focusNode:
                                        _passwordFocusNode, // Added focusNode
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  CustomButton(
                                    text: 'Sign-In',
                                    onPressed: () {
                                      loginController.login();

                                      print('Sign-In button pressed');
                                    },
                                    width: 327,
                                    height: 52,
                                    borderRadius: 12,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  InterCustomText(
                                    text: 'Forgot Password?',
                                    textColor: primaryColor,
                                    fontsize: 14.sp,
                                  )
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Container(
                                  //       height: 1.h,
                                  //       width: 102.w,
                                  //       color: Color(0xffE6E6E6),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 8.w,
                                  //     ),
                                  //     InterCustomText(
                                  //       textAlign: TextAlign.center,
                                  //       text: 'or continue with',
                                  //       textColor: Color(0xff828282),
                                  //       fontsize: 14.sp,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 8.w,
                                  //     ),
                                  //     Container(
                                  //       height: 1.h,
                                  //       width: 102.w,
                                  //       color: Color(0xffE6E6E6),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 10.h,
                                  // ),
                                  // Container(
                                  //   width: 327.w,
                                  //   height: 40.h,
                                  //   decoration: BoxDecoration(
                                  //     color: primaryColor.withOpacity(0.3),
                                  //     borderRadius: BorderRadius.circular(8.r),
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: [
                                  //       Image.asset(
                                  //         AppImages.googleIcon,
                                  //         height: 20.h,
                                  //         width: 20.w,
                                  //       ),
                                  //       SizedBox(
                                  //         width: 8.w,
                                  //       ),
                                  //       Center(
                                  //         child: InterCustomText(
                                  //           textAlign: TextAlign.center,
                                  //           text: 'Google',
                                  //           textColor: primaryColor,
                                  //           fontsize: 14.sp,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 24.h,
                                  // ),
                                  // RichText(
                                  //   textAlign: TextAlign.center,
                                  //   text: TextSpan(
                                  //     text:
                                  //         'By clicking continue, you agree to our ',
                                  //     style: GoogleFonts.inter(
                                  //       color: Color(0xff828282),
                                  //       fontWeight: FontWeight.w400,
                                  //       fontSize: 12.sp,
                                  //     ),
                                  //     children: [
                                  //       TextSpan(
                                  //         text: 'Terms of Service',
                                  //         style: GoogleFonts.inter(
                                  //           color: primaryColor,
                                  //           fontWeight: FontWeight.w400,
                                  //           fontSize: 12.sp,
                                  //         ),
                                  //         recognizer: TapGestureRecognizer()
                                  //           ..onTap = () {
                                  //             // Navigate to the Terms of Service page
                                  //           },
                                  //       ),
                                  //       TextSpan(
                                  //         text: ' and ',
                                  //         style: GoogleFonts.inter(
                                  //           color: Color(0xff828282),
                                  //           fontWeight: FontWeight.w400,
                                  //           fontSize: 12.sp,
                                  //         ),
                                  //       ),
                                  //       TextSpan(
                                  //         text: 'Privacy Policy',
                                  //         style: GoogleFonts.inter(
                                  //           color: primaryColor,
                                  //           fontWeight: FontWeight.w400,
                                  //           fontSize: 12.sp,
                                  //         ),
                                  //         recognizer: TapGestureRecognizer()
                                  //           ..onTap = () {
                                  //             // Navigate to the Privacy Policy page
                                  //           },
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
      await _uploadImageToFirebase(image);
    }
  }

  // Storage
  Future<void> _uploadImageToFirebase(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef
          .child('user_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = imageRef.putFile(File(image.path));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await _saveImageUrlToFirestore(downloadUrl);
      print('Image uploaded and URL saved successfully: $downloadUrl');
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }

  // Database
  Future<void> _saveImageUrlToFirestore(String downloadUrl) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('userDetails').doc(userId);
    await userDocRef.set({
      'profile_image': downloadUrl,
    }, SetOptions(merge: true));
  }
}
