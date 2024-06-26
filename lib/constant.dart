import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'controllers/auth_controllers.dart';

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.black;
var secondaryColor = Colors.greenAccent;
const borderColor = Colors.grey;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var authController = AuthController.instance;