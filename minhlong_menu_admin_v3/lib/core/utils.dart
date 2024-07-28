import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/common/network/dio_client.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/order_item.dart';
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

  static bool checkExistFood(OrderItem order, int foodID) {
    var isExist = false;
    for (FoodOrderModel e in order.foodOrders) {
      if (e.id == foodID) {
        isExist = true;
        break;
      }
    }
    return isExist;
  }

  static Future<String?> uploadImage({
    required File file,
    required String path,
    required ValueNotifier<double> loading,
  }) async {
    try {
      String newFileName = '${DateTime.now().millisecondsSinceEpoch}.webp';

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path, filename: newFileName),
      });

      // Send the request using Dio
      final response = await dio.post(
        ApiConfig.uploadImage,
        data: formData,
        queryParameters: {'path': path},
        onSendProgress: (count, total) {
          loading.value = 100.0 * (count / total);
        },
      );

      if (response.statusCode != HttpStatus.ok) {
        return null;
      }

      return response.data['image'];
    } on DioException catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // static Future<String?> uploadImage(
  //     {required File file,
  //     required String path,
  //     required ValueNotifier<double> loading}) async {
  //   await file.rename('${DateTime.now()}.webp');
  //   var filePath = file.path.split('/').last;

  //   FormData formData = FormData.fromMap({
  //     "image": await MultipartFile.fromFile(file.path, filename: filePath),
  //   });
  //   final response = await dio.post(
  //     ApiConfig.uploadImage,
  //     data: formData,
  //     queryParameters: {'path': path},
  //     onSendProgress: (count, total) {
  //       Logger().w('count: $count, total: $total');
  //       loading.value = 100.0 * (count / total);
  //     },
  //   );
  //   if (response.statusCode != 200) {
  //     return null;
  //   }

  //   return response.data['image'];
  // }

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

  static String formatStringToTime(String date,
      {bool isShort = false, bool isTime = false}) {
    DateTime dateTime = DateTime.parse(date);

    final formattedDate = DateFormat('HH:mm');
    return formattedDate.format(dateTime);
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

  static void joinRoom(WebSocketChannel channel, dynamic room) {
    if (channel.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    Map<String, dynamic> data = {
      'event': 'join-room',
      'room': room,
    };
    channel.sink.add(jsonEncode(data));
  }

  static void leaveRoom(WebSocketChannel channel, dynamic room) {
    if (channel.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    Map<String, dynamic> data = {
      'event': 'left-room',
      'room': room,
    };
    channel.sink.add(jsonEncode(data));
  }
}
