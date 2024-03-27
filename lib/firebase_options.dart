// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBwLSAqklcotrhc3DMjvcUb3E8zoFoZNB0',
    appId: '1:826673770549:web:4733c2af4bb993b63c817c',
    messagingSenderId: '826673770549',
    projectId: 'ah-analytics-production',
    authDomain: 'ah-analytics-production.firebaseapp.com',
    storageBucket: 'ah-analytics-production.appspot.com',
    measurementId: 'G-TNRVET9ZLB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQWBag-pWtPeqxSmUbuIzY3XwKhexDd_g',
    appId: '1:826673770549:android:711a9d2b9e57eb113c817c',
    messagingSenderId: '826673770549',
    projectId: 'ah-analytics-production',
    storageBucket: 'ah-analytics-production.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnDG49QZyh4-MtpPUx5FHzh3HcPHBjsK0',
    appId: '1:826673770549:ios:dbf27db7137433c83c817c',
    messagingSenderId: '826673770549',
    projectId: 'ah-analytics-production',
    storageBucket: 'ah-analytics-production.appspot.com',
    iosBundleId: 'com.example.ahAnalytics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnDG49QZyh4-MtpPUx5FHzh3HcPHBjsK0',
    appId: '1:826673770549:ios:dbf27db7137433c83c817c',
    messagingSenderId: '826673770549',
    projectId: 'ah-analytics-production',
    storageBucket: 'ah-analytics-production.appspot.com',
    iosBundleId: 'com.example.ahAnalytics',
  );
}
