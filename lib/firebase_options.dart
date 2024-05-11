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
    apiKey: 'AIzaSyDRC0L7EfNJtftUa9y75MSo64416yDAqq4',
    appId: '1:479536336375:web:109e2b2325c9a1544632f2',
    messagingSenderId: '479536336375',
    projectId: 'mabook-ea750',
    authDomain: 'mabook-ea750.firebaseapp.com',
    storageBucket: 'mabook-ea750.appspot.com',
    measurementId: 'G-24DZEEH8NY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxJw8JeAMvA9lOjcBI_-HL94emyz4Q_6A',
    appId: '1:479536336375:android:a6a655e9a3ec33d14632f2',
    messagingSenderId: '479536336375',
    projectId: 'mabook-ea750',
    storageBucket: 'mabook-ea750.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4rH463zE95kcNWbH17JaJa24SflYXkVs',
    appId: '1:479536336375:ios:c342fa61cb0836324632f2',
    messagingSenderId: '479536336375',
    projectId: 'mabook-ea750',
    storageBucket: 'mabook-ea750.appspot.com',
    androidClientId: '479536336375-k7dqd5s0k7mb3vp0ivat0n789ojahvrg.apps.googleusercontent.com',
    iosClientId: '479536336375-pnnvee6cfvcac98m8lcj85924fne856d.apps.googleusercontent.com',
    iosBundleId: 'com.example.mabook',
  );
}
