import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/controller/user_controller.dart';
import '../const/image.dart';
import '../view/transition_screen/transition_one.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final UserController userController = Get.put(UserController());

  late final Animation<double> _opacityAnimation;
  late final AnimationController _controller2;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    // Call the method to perform asynchronous tasks
    _initAsyncTasks();
  }

  Future<void> _initAsyncTasks() async {
    await userController.getDeviceStoreToken();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TransitionOne(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: 0.0, end: 1.0);
        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            right: 20,
            top: 80,
            child: Align(
              alignment: Alignment.topRight,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Image.asset(
                        AppImages.bglogo,
                        height: 130,
                        width: 130,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Image.asset(AppImages.bgName),
          ),
        ],
      ),
    );
  }


}
