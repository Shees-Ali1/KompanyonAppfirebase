import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/widgets/custom_textfield.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: primaryText),
        automaticallyImplyLeading: true,
        backgroundColor: backgroundColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();

        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterCustomText(
                fontsize: 22,
                text: 'Change Password',
                fontWeight: FontWeight.w500,
                textColor: primaryColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              InterCustomText(
                fontsize: 14,
                text:
                    'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
                fontWeight: FontWeight.w500,
                textColor: secondaryText,
              ),
              SizedBox(
                height: 30.h,
              ),
              InputField(
                hint: "Enter your email",
                keyboard: TextInputType.name,
                label: "Your email address",
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                height: 62.h,
                text: 'Send Link',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
