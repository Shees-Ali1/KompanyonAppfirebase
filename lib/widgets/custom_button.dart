import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final BoxBorder? border;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color = primaryColor,
    this.textColor = Colors.white,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500, this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 21.h),
        width: width != null ? width!.w : null,
        height: height != null ? height!.h : null,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: border
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}

/*
 Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            child: CustomButton(
              text: "",
              fontSize: 16.sp,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>

                );
              },
              height: 52.h,
            ),
          )*/