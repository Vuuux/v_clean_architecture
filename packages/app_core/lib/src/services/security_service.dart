// import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
//
// class SecurityService {
//   Future<bool> isSecure() async {
//     try {
//       // Check if device is jailbroken (iOS) or rooted (Android)
//       final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
//
//       // Check if device is running on emulator/simulator
//       final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
//
//       // Device is secure if it's not jailbroken/rooted,
//       // is a real device, and not in developer mode
//       return !isJailBroken && isRealDevice;
//     } catch (e) {
//       // If detection fails, assume device is not secure
//       return false;
//     }
//   }
// }
