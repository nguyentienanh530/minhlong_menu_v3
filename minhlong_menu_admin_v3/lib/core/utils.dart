import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Ultils {
  Future<dynamic> pickImage() async {
    dynamic imageFile;
    final imagePicker = ImagePicker();
    var imagepicked = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      imageFile = File(imagepicked.path);

      Logger().d('Image Path: ${imageFile.path}');
    } else {
      Logger().d('No image selected!');
    }
    return imageFile;
  }

  static String formatDateToString(String date,
      {bool isShort = false, bool isTime = false}) {
    DateTime dateTime = DateTime.parse(date);
    if (isShort) {
      final formattedDate = DateFormat('dd-MM-yyyy');
      return formattedDate.format(dateTime);
    }

    if (isTime) {
      final formattedDate = DateFormat('HH:mm - dd/MM/yyyy');
      return formattedDate.format(dateTime);
    }
    return 'Ngày ${dateTime.day} tháng ${dateTime.month} năm ${dateTime.year}';
  }

  static String currencyFormat(double double) {
    final oCcy = NumberFormat("###,###,###", "vi");
    return oCcy.format(double);
  }

  static void sendSocket(
      WebSocketChannel channel, String event, dynamic payload) {
    if (channel.closeCode != null) {
      debugPrint('Not connected');
      return;
    }

    Map<String, dynamic> data = {
      'event': event,
      'payload': payload,
    };
    channel.sink.add(jsonEncode(data));
  }
}
