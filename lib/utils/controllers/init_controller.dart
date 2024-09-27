//import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:fltr/utils/pages.dart';

typedef FbAuthListener = void Function({required bool status});

class LaunchController extends GetxController {


 



  @override
  void onInit() {
    super.onInit();
   
   
  }

  @override
  void onClose() {
 //   _authStateSubscription.cancel();
    super.onClose();
    debugPrint("closed");
  }
}
