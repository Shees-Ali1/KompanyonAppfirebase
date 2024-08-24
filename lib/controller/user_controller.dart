import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserController extends GetxController{
  String? token;

  Future<void> getDeviceStoreToken() async {
    try {
      if (Platform.isIOS) {
        token = await FirebaseMessaging.instance.getAPNSToken();
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseFirestore.instance
              .collection('userDetails')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({'fcmToken': token}, SetOptions(merge: true));
        }
      } else if (Platform.isAndroid) {
        token = await FirebaseMessaging.instance.getToken();
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseFirestore.instance
              .collection('userDetails')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({'fcmToken': token}, SetOptions(merge: true));
        }
      }
    } catch (e) {
      print('Error Storing token');
    }
  }

}