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
    apiKey: 'AIzaSyB_1JDr7eHaPB8P8dh0WWHt2fn5LXWOM00',
    appId: '1:101204525967:web:1dd028ea5ca25b37dd81fa',
    messagingSenderId: '101204525967',
    projectId: 'childing-9ddea',
    authDomain: 'childing-9ddea.firebaseapp.com',
    storageBucket: 'childing-9ddea.appspot.com',
    measurementId: 'G-KGB45L6GKB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBA7xrA2uRX2QXG5SIu9kNK5Jmwc9pXOlI',
    appId: '1:101204525967:android:8f85b9b75b5dd955dd81fa',
    messagingSenderId: '101204525967',
    projectId: 'childing-9ddea',
    storageBucket: 'childing-9ddea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApfAZfMR_ObHUIPJYcDmbnn0trhwHVcas',
    appId: '1:101204525967:ios:b35c1ee8d44dde34dd81fa',
    messagingSenderId: '101204525967',
    projectId: 'childing-9ddea',
    storageBucket: 'childing-9ddea.appspot.com',
    iosClientId: '101204525967-i5n18rpt58uujabmnos7enk7mb753qgk.apps.googleusercontent.com',
    iosBundleId: 'com.example.preggo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApfAZfMR_ObHUIPJYcDmbnn0trhwHVcas',
    appId: '1:101204525967:ios:c7e0786ec3e4a92edd81fa',
    messagingSenderId: '101204525967',
    projectId: 'childing-9ddea',
    storageBucket: 'childing-9ddea.appspot.com',
    iosClientId: '101204525967-3jtv4dptphhoo802trvlarrbv7n7t27e.apps.googleusercontent.com',
    iosBundleId: 'com.tnguyen2791.childing',
  );
}