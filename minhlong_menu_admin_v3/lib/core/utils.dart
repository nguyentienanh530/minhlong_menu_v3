import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/common/network/dio_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'api_config.dart';

class Ultils {
  static Future<dynamic> pickImage() async {
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

  static Future<String?> uploadImage(
      {required File file,
      required String path,
      required ValueNotifier<double> loading}) async {
    // final Response response = await dioClient.dio!
    //     .post(ApiConfig.uploadAvatar, data: {'avatar': file});
    var filePath = file.path.split('/').last;
    print('filePath: $filePath');
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: filePath),
    });
    final response = await DioClient().dio!.post(
      ApiConfig.uploadImage,
      data: formData,
      queryParameters: {'path': path},
      onSendProgress: (count, total) {
        Logger().w('count: $count, total: $total');
      },
    );
    if (response.statusCode != 200) {
      return null;
    }

    return response.data['image'];
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
