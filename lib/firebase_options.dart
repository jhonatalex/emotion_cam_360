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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAhJLTKW1UNJ58JT_b4yTs1-_WKfHbHa8Y',
    appId: '1:869955665095:web:13e9e5262eb2e9ccced2e2',
    messagingSenderId: '869955665095',
    projectId: 'emotion360-72a62',
    authDomain: 'emotion360-72a62.firebaseapp.com',
    storageBucket: 'emotion360-72a62.appspot.com',
    measurementId: 'G-S2P90ENWHT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDm7Qa_oYIMBTrrOBA7i9Qr7qqloPlGnPo',
    appId: '1:869955665095:android:8fc64eacf1bf7572ced2e2',
    messagingSenderId: '869955665095',
    projectId: 'emotion360-72a62',
    storageBucket: 'emotion360-72a62.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeBjnFyH-3rV2-Jd1ClIKuJSgkjH2Nk14',
    appId: '1:869955665095:ios:67963b020be0a224ced2e2',
    messagingSenderId: '869955665095',
    projectId: 'emotion360-72a62',
    storageBucket: 'emotion360-72a62.appspot.com',
    androidClientId: '869955665095-cfo89a2bnuiqkngf4910o6hiq1sletab.apps.googleusercontent.com',
    iosClientId: '869955665095-dkt40qdhdkdk8d89apss6ps4f0hrnnrh.apps.googleusercontent.com',
    iosBundleId: 'com.marketglobal.emotionCam360',
  );
}
