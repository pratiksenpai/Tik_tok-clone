import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/views/screens/add_video_screen.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/seach_screens.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';

//color
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//controller
var authController = AuthController.instance;

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const Text('Message Screen'),
  ProfileScreen(uid: authController.user.uid)
];
