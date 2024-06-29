// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBu5xITL2N6owoBPHmKzCyUVQ1YaOBOVIA',
    appId: '1:732085299218:web:0f462ef0ee264b683850cb',
    messagingSenderId: '732085299218',
    projectId: 'outwork-1',
    authDomain: 'outwork-1.firebaseapp.com',
    storageBucket: 'outwork-1.appspot.com',
    measurementId: 'G-JJVKSBDKWR',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANHqOLFGJeTUiSPqFzNsOV2b9GGpp-3W4',
    appId: '1:732085299218:ios:aaacaaeb8729edcc3850cb',
    messagingSenderId: '732085299218',
    projectId: 'outwork-1',
    storageBucket: 'outwork-1.appspot.com',
    iosBundleId: 'com.example.workoutApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANHqOLFGJeTUiSPqFzNsOV2b9GGpp-3W4',
    appId: '1:732085299218:ios:aaacaaeb8729edcc3850cb',
    messagingSenderId: '732085299218',
    projectId: 'outwork-1',
    storageBucket: 'outwork-1.appspot.com',
    iosBundleId: 'com.example.workoutApp',
  );
}
