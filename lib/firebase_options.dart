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
        return windows;
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
    apiKey: 'AIzaSyBlI4jJ50pY0Nx68evUXKe1ybsadhZbiS4',
    appId: '1:514154554859:web:a7ccb43de961628890e5ae',
    messagingSenderId: '514154554859',
    projectId: 'ah-analytics-testing',
    authDomain: 'ah-analytics-testing.firebaseapp.com',
    storageBucket: 'ah-analytics-testing.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBL1eb4LVyuQbAgrzwwnHO_t_XsfgV3Kk',
    appId: '1:514154554859:android:3ac6d16789b45d1d90e5ae',
    messagingSenderId: '514154554859',
    projectId: 'ah-analytics-testing',
    storageBucket: 'ah-analytics-testing.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXJjxjyXtk-b0LGvOEXBsmqUzRggbyg74',
    appId: '1:514154554859:ios:f0a392a154030d8c90e5ae',
    messagingSenderId: '514154554859',
    projectId: 'ah-analytics-testing',
    storageBucket: 'ah-analytics-testing.appspot.com',
    iosBundleId: 'com.example.ahAnalytics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXJjxjyXtk-b0LGvOEXBsmqUzRggbyg74',
    appId: '1:514154554859:ios:f0a392a154030d8c90e5ae',
    messagingSenderId: '514154554859',
    projectId: 'ah-analytics-testing',
    storageBucket: 'ah-analytics-testing.appspot.com',
    iosBundleId: 'com.example.ahAnalytics',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBlI4jJ50pY0Nx68evUXKe1ybsadhZbiS4',
    appId: '1:514154554859:web:c39911b389db7d7990e5ae',
    messagingSenderId: '514154554859',
    projectId: 'ah-analytics-testing',
    authDomain: 'ah-analytics-testing.firebaseapp.com',
    storageBucket: 'ah-analytics-testing.appspot.com',
  );

}