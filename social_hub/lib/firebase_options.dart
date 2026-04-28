// File generated manually (fixed for web support)
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

      case TargetPlatform.macOS:
        return macos;

      default:
        throw UnsupportedError('This platform is not supported');
    }
  }

  /// 🔥 ANDROID
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDC49_cKdImZh1bUjZ4VNULfNxfI5oNNc8',
    appId: '1:217590454475:android:46201e7adfccf9a3dca34e',
    messagingSenderId: '217590454475',
    projectId: 'socialhub-f7abe',
    storageBucket: 'socialhub-f7abe.firebasestorage.app',
  );

  /// 🔥 MACOS
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDC49_cKdImZh1bUjZ4VNULfNxfI5oNNc8',
    appId: '1:217590454475:ios:46201e7adfccf9a3dca34e',
    messagingSenderId: '217590454475',
    projectId: 'socialhub-f7abe',
    storageBucket: 'socialhub-f7abe.firebasestorage.app',
  );

  /// 🔥 WEB (ЭТО БЫЛО ТВОЕЙ ПРОБЛЕМОЙ)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAPK3EFn-PODm5FGNR5aWin9uDK7Up3dzI",
    appId: "1:217590454475:web:7d6a832d8b5171d0dca34e",
    messagingSenderId: "217590454475",
    projectId: "socialhub-f7abe",
    authDomain: "socialhub-f7abe.firebaseapp.com",
    storageBucket: "socialhub-f7abe.firebasestorage.app",
  );
}
