
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
    apiKey: 'AIzaSyCI_zEKZi2QU9ZJsnaq8MFbEd9rdd-eM4E',
    appId: '1:766710819582:web:ca81a889ce2313102b13af',
    messagingSenderId: '766710819582',
    projectId: 't-store-2d16c',
    authDomain: 't-store-2d16c.firebaseapp.com',
    storageBucket: 't-store-2d16c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHoNvgoVEIZwvSbgUs3hxqL38Y_S1XyZM',
    appId: '1:766710819582:android:773d4c9547469f4c2b13af',
    messagingSenderId: '766710819582',
    projectId: 't-store-2d16c',
    storageBucket: 't-store-2d16c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhG0r7xOCujCTKiq2wR3rXGrd-Sx4krhE',
    appId: '1:766710819582:ios:4b558e03effac8b72b13af',
    messagingSenderId: '766710819582',
    projectId: 't-store-2d16c',
    storageBucket: 't-store-2d16c.appspot.com',
    androidClientId: '766710819582-kcoipcsfjvl7u36l0qb0tas7d5mo7aa1.apps.googleusercontent.com',
    iosClientId: '766710819582-2s6peqvi465dslqssi21a710kg0g7jl6.apps.googleusercontent.com',
    iosBundleId: 'com.example.tStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDhG0r7xOCujCTKiq2wR3rXGrd-Sx4krhE',
    appId: '1:766710819582:ios:4b558e03effac8b72b13af',
    messagingSenderId: '766710819582',
    projectId: 't-store-2d16c',
    storageBucket: 't-store-2d16c.appspot.com',
    androidClientId: '766710819582-kcoipcsfjvl7u36l0qb0tas7d5mo7aa1.apps.googleusercontent.com',
    iosClientId: '766710819582-2s6peqvi465dslqssi21a710kg0g7jl6.apps.googleusercontent.com',
    iosBundleId: 'com.example.tStore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCI_zEKZi2QU9ZJsnaq8MFbEd9rdd-eM4E',
    appId: '1:766710819582:web:eba665013ae046d32b13af',
    messagingSenderId: '766710819582',
    projectId: 't-store-2d16c',
    authDomain: 't-store-2d16c.firebaseapp.com',
    storageBucket: 't-store-2d16c.appspot.com',
  );

}