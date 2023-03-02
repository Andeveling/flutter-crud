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
    apiKey: 'AIzaSyDUUM3wLZZGq-uQtfxMe9FN62dgt21YNg0',
    appId: '1:649915718848:web:d4cb380024960c1005e125',
    messagingSenderId: '649915718848',
    projectId: 'flutter-test-db8a9',
    authDomain: 'flutter-test-db8a9.firebaseapp.com',
    storageBucket: 'flutter-test-db8a9.appspot.com',
    measurementId: 'G-M0X710SX4W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBK4wfpc8gNEbLY4FK1A8nlD36tYWBGZtA',
    appId: '1:649915718848:android:a5bb8e5e20409e3505e125',
    messagingSenderId: '649915718848',
    projectId: 'flutter-test-db8a9',
    storageBucket: 'flutter-test-db8a9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGiMofnV20C20Yq5_fXRB_Cg61Tuv0y7o',
    appId: '1:649915718848:ios:2a900df35b6d5a0705e125',
    messagingSenderId: '649915718848',
    projectId: 'flutter-test-db8a9',
    storageBucket: 'flutter-test-db8a9.appspot.com',
    iosClientId: '649915718848-teek7jjrt3ecv1g6d9vfr7gh86g0em1e.apps.googleusercontent.com',
    iosBundleId: 'com.example.adroidCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGiMofnV20C20Yq5_fXRB_Cg61Tuv0y7o',
    appId: '1:649915718848:ios:2a900df35b6d5a0705e125',
    messagingSenderId: '649915718848',
    projectId: 'flutter-test-db8a9',
    storageBucket: 'flutter-test-db8a9.appspot.com',
    iosClientId: '649915718848-teek7jjrt3ecv1g6d9vfr7gh86g0em1e.apps.googleusercontent.com',
    iosBundleId: 'com.example.adroidCrud',
  );
}