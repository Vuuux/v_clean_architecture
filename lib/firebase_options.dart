// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class AppFirebaseOptions {
  static FirebaseOptions get nonProd {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
          storageBucket: '',
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
          storageBucket: '',
          androidClientId: '',
          iosClientId: '',
          iosBundleId: '',
        );
      default:
        throw UnsupportedError('This platform is not supported');
    }
  }

  static FirebaseOptions get prod {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
          storageBucket: '',
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
          storageBucket: '',
          androidClientId: '',
          iosClientId: '',
          iosBundleId: '',
        );
      default:
        throw UnsupportedError('This platform is not supported');
    }
  }
}
