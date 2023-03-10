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
    apiKey: 'AIzaSyChTNM-wqLvyyJixpezsTCT1j_ZVvGMqjE',
    appId: '1:336023171327:web:51ed853a5edd2e6ede5cca',
    messagingSenderId: '336023171327',
    projectId: 'shoppingapp-cae78',
    authDomain: 'shoppingapp-cae78.firebaseapp.com',
    storageBucket: 'shoppingapp-cae78.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4treihXSP6EURP9-0RPQrCzc5M-g2dxA',
    appId: '1:336023171327:android:efd09baa06a99bbede5cca',
    messagingSenderId: '336023171327',
    projectId: 'shoppingapp-cae78',
    storageBucket: 'shoppingapp-cae78.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4o4qxiMumvXLhmKZVckTfG8lIaD0Vncc',
    appId: '1:336023171327:ios:c8d0cd21d32cf2c5de5cca',
    messagingSenderId: '336023171327',
    projectId: 'shoppingapp-cae78',
    storageBucket: 'shoppingapp-cae78.appspot.com',
    iosClientId: '336023171327-0so0pu6aqir67frumfcpeb6eh4dccvvn.apps.googleusercontent.com',
    iosBundleId: 'com.example.fuel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4o4qxiMumvXLhmKZVckTfG8lIaD0Vncc',
    appId: '1:336023171327:ios:c8d0cd21d32cf2c5de5cca',
    messagingSenderId: '336023171327',
    projectId: 'shoppingapp-cae78',
    storageBucket: 'shoppingapp-cae78.appspot.com',
    iosClientId: '336023171327-0so0pu6aqir67frumfcpeb6eh4dccvvn.apps.googleusercontent.com',
    iosBundleId: 'com.example.fuel',
  );
}
