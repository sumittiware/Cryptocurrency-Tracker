import 'package:flutter/material.dart';

class ImagesUtils {
  static getCryptoIcon(String name) {
    return NetworkImage(
      'https://coinicons-api.vercel.app/api/icon/$name',
    );
  }
}
