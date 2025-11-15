import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBh8IaZIe8DW6MIuu5FVCkYJHXLv6UQ-3U',
    appId: '1:649127326247:web:92705d7ff2bbcb46b85402',
    messagingSenderId: '649127326247',
    projectId: 'app-restaurante-883db',
    authDomain: 'app-restaurante-883db.firebaseapp.com',
    storageBucket: 'app-restaurante-883db.firebasestorage.app',
    measurementId: 'G-DLXZG8GZEG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZnC08N13hHDlegdXrldUB4Qrnlye-T68',
    appId: '1:649127326247:android:1ee3105b47e7927fb85402',
    messagingSenderId: '649127326247',
    projectId: 'app-restaurante-883db',
    storageBucket: 'app-restaurante-883db.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtxyzl5mmyvEd_Zcl1K7Wd3Eykj6XeiB4',
    appId: '1:649127326247:ios:e75b4ce0cfe94c96b85402',
    messagingSenderId: '649127326247',
    projectId: 'app-restaurante-883db',
    storageBucket: 'app-restaurante-883db.firebasestorage.app',
    iosBundleId: 'com.example.appRestaurante',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtxyzl5mmyvEd_Zcl1K7Wd3Eykj6XeiB4',
    appId: '1:649127326247:ios:e75b4ce0cfe94c96b85402',
    messagingSenderId: '649127326247',
    projectId: 'app-restaurante-883db',
    storageBucket: 'app-restaurante-883db.firebasestorage.app',
    iosBundleId: 'com.example.appRestaurante',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBh8IaZIe8DW6MIuu5FVCkYJHXLv6UQ-3U',
    appId: '1:649127326247:web:388838f1bf447587b85402',
    messagingSenderId: '649127326247',
    projectId: 'app-restaurante-883db',
    authDomain: 'app-restaurante-883db.firebaseapp.com',
    storageBucket: 'app-restaurante-883db.firebasestorage.app',
    measurementId: 'G-PM557BVLEG',
  );

}