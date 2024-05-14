import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppService{
  static final AppService _instance = AppService._internal();
  AppService._internal();
  factory AppService() => _instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> loggedinProfile = {};

}