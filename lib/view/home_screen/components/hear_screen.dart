import 'dart:io';
import 'package:kompanyon_app/widgets/custom_search.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:audioplayers/audioplayers.dart';

class HearScreen extends StatefulWidget {
  const HearScreen({super.key});

  @override
  State<HearScreen> createState() => _HearScreenState();
}

class _HearScreenState extends State<HearScreen>
    with SingleTickerProviderStateMixin {
  AudioPlayer audioPlayer = AudioPlayer();
  late AnimationController _controller;
  late Animation<Offset> _upSlideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _rightSlideAnimation;
  String? localFilePath;
  int? playingIndex; // Track which item is currently playing
  final FocusNode searchFocusNode = FocusNode();

  final List<Map<String, String>> items = [
    {
      'Category': 'Leadership',
      'title': 'Setting Clear Intentions',
      'duration': '2 min',
      'file': 'kompanyon-audio.mp3', // Corresponding file for each track
    },
    {
      'Category': 'Leadership',
      'title': 'Visualization for Deep Work',
      'duration': '4 min',
      'file': 'CONFLICT AVOIDANCE MASTER.mp3',
    },
    {
      'Category': 'Leadership',
      'title': 'LISTENING WITH EMPATHY MASTER',
      'duration': '4 min',
      'file': 'LISTENING WITH EMPATHY MASTER.mp3',
    },
    {
      'Category': 'Leadership',
      'title': 'TEAM COLLABORATION MEDITATION MASTER',
      'duration': '3 min',
      'file': 'TEAM COLLABORATION MEDITATION MASTER.mp3',
    },
  ];

  Future<void> playAudio(int index) async {
    try {
      // Get the file name from the items list
      String assetFileName = items[index]['file']!;

      // Load the audio file from assets
      final byteData = await rootBundle.load('assets/$assetFileName');

      // Create a file in the temporary directory and write the asset data
      final file =
      File('${(await getTemporaryDirectory()).path}/$assetFileName');
      await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

      // Play the audio file
      await audioPlayer.play(DeviceFileSource(file.path));

      setState(() {
        playingIndex = index; // Set the currently playing index
      });
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<void> pauseAudio() async {
    try {
      await audioPlayer.pause();
      setState(() {
        playingIndex = null; // Reset the playing index when paused
      });
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // loadAsset();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Slide in from below for list items
    _upSlideAnimation = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(_controller);

    _rightSlideAnimation =
        Tween<Offset>(begin: Offset(-2.0, 1.0), end: Offset.zero)
            .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                Spacer(),
                SlideTransition(
                  position: _upSlideAnimation,
                  child: const InterCustomText(
                    text: 'Hear',
                    textColor: primaryColor,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Spacer(),
              ],
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                color: greyColor,
                thickness: 0.2,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SlideTransition(
                  position: _rightSlideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16.w,
                      ),
                      CustomSearch(focusNode: searchFocusNode),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 37.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Category'),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text('Title'),
                          Spacer(),
                          Text('Length'),
                          SizedBox(
                            width: 46.w,
                          ),
                        ],
                      ),
                      Divider(
                        color: containerBorder,
                      )
                    ],
                  ),
                ),
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final isPlayingItem = playingIndex == index;
                      return Padding(
                        padding: EdgeInsets.only(left: 37.w, top: 5.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InterCustomText(
                                  overflow: TextOverflow.ellipsis,
                                  text: items[index]['Category'] ?? "",
                                  fontsize: 12.sp,
                                  textColor: blackColor.withOpacity(0.90),
                                ),
                                SizedBox(width: 22),
                                Expanded(
                                  child: InterCustomText(
                                    overflow: TextOverflow.ellipsis,
                                    text: items[index]['title']!,
                                    fontsize: 14.sp,
                                    textColor: blackColor,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Container(
                                  width: 48.w,
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: containerBorder),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                      child: InterCustomText(
                                        text: items[index]['duration']!,
                                        fontsize: 12.sp,
                                        textColor: blackColor,
                                      )),
                                ),
                                SizedBox(width: 12.w),
                                GestureDetector(
                                  onTap: () {
                                    if (isPlayingItem) {
                                      pauseAudio();
                                    } else {
                                      playAudio(index);
                                    }
                                  },
                                  child: Icon(isPlayingItem
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                ),
                                SizedBox(width: 12.w),
                              ],
                            ),
                            if (index != items.length - 1)
                              Divider(
                                color: containerBorder,
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
