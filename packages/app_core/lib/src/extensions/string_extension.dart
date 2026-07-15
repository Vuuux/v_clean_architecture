// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/export.dart';

enum ImageSize { small, medium, large, thumbnail }

extension StringExtension on String {
  String encryptWithPublicKey(String publicKey) {
    final publicKeyPEM = '-----BEGIN PUBLIC KEY-----\n$publicKey\n-----END';
    final rsaPublicKey = RSAKeyParser().parse(publicKeyPEM) as RSAPublicKey;

    final encryptor = PKCS1Encoding(RSAEngine())
      ..init(true, PublicKeyParameter<RSAPublicKey>(rsaPublicKey));
    final plainTextBytes = Uint8List.fromList(utf8.encode(this));
    final encryptedStr = encryptor.process(plainTextBytes);

    return base64Encode(encryptedStr);
  }
}

extension StringRegexExtension on String? {
  bool get isEmptyOrNull {
    return this == null || this!.trim().isEmpty;
  }

  bool get isNotEmptyOrNull {
    return this != null && this!.trim().isNotEmpty;
  }

  bool isValidEmail() {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+',
    ).hasMatch(this ?? '');
  }

  String getFileUrl({required String host, ImageSize? size}) {
    if (isEmptyOrNull) return '';
    if (RegExp(r'^(https?:\/\/)').hasMatch(this ?? '')) {
      return this ?? '';
    }
    if (size != null) {
      final startIndex = this!.lastIndexOf('default');
      if (startIndex == -1) {
        return '$host$this';
      }
      final endIndex = startIndex + 'default'.length;

      return '$host${this!.replaceRange(startIndex, endIndex, size.name)}';
    }
    return '$host$this';
  }

  String getFileNameFromUrl() {
    final uri = Uri.parse(this ?? '');
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
  }

  String getFileExtension() {
    return this?.split('.').last ?? '';
  }

  String getAssetImageUrl({
    required String host,
    required double devicePixelRatio,
  }) {
    final imagePath = this?.replaceFirst(
      RegExp('{dpr}'),
      devicePixelRatio.round().clamp(1, 3).toString(),
    );
    return '$host/$imagePath';
  }
}

extension HexColorX on String? {
  Color toColor({Color fallback = Colors.black}) {
    final value = this;
    if (value == null || value.trim().isEmpty) return fallback;
    var hex = value.trim().replaceAll('#', '').replaceAll('0x', '');

    // Expand 3-char shorthand like F0B -> FF00BB
    if (hex.length == 3) {
      hex = hex.split('').map((c) => c * 2).join();
    }

    // If only RRGGBB, prepend alpha FF
    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    // Validate
    if (!RegExp(r'^[0-9a-fA-F]{8}$').hasMatch(hex)) {
      return fallback;
    }
    try {
      return Color(int.parse('0x$hex'));
    } catch (_) {
      return fallback;
    }
  }

  bool isHexColor() {
    final v = this;
    if (v == null) return false;
    return RegExp(
      r'^#?[0-9a-fA-F]{3}([0-9a-fA-F]{3})?$|^#?[0-9a-fA-F]{6}([0-9a-fA-F]{2})?$',
    ).hasMatch(v);
  }
}
