import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';


mixin Base64Mixin {
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Uint8List dataFromBase64String(String base64String) {
    final string1 = base64String.replaceAll('data:image/png;base64,', '');
    final string2 = string1.replaceAll('data:image/jpg;base64,', '');
    final string3 = string2.replaceAll('data:audio/mp3;base64,', '');
    final string4 = string3.replaceAll('data:image/svg+xml;base64,', '');
    final string5 = string4.replaceAll('data:image/jpeg;base64,', '');
    final string6 = string5.replaceAll('data:audio/wav;base64,', '');
    return base64Decode(string6);
  }

  // Future<Uint8List?> byteFromString(String url) async {
  //   final base64String = await DbRepository.to.getBase64(url);
  //   if (base64String != null) {
  //     final string1 = base64String.replaceAll('data:image/png;base64,', '');
  //     final string2 = string1.replaceAll('data:image/jpg;base64,', '');
  //     final string3 = string2.replaceAll('data:audio/mp3;base64,', '');
  //     final string4 = string3.replaceAll('data:image/svg+xml;base64,', '');
  //     final string5 = string4.replaceAll('data:image/jpeg;base64,', '');
  //     final string6 = string5.replaceAll('data:audio/wav;base64,', '');
  //     return base64Decode(string6);
  //   }
  //   return null;
  // }
}
