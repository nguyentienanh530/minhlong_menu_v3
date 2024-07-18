import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../common/network/dio_client.dart';
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

  String formatDateToString(String date, {bool isShort = false}) {
    DateTime dateTime = DateTime.parse(date);
    if (isShort) {
      final formattedDate = DateFormat('dd-MM-yyyy');
      return formattedDate.format(dateTime);
    }
    return 'Ngày ${dateTime.day} tháng ${dateTime.month} năm ${dateTime.year}';
  }

  static String currencyFormat(double double) {
    final oCcy = NumberFormat("###,###,###", "vi");
    return oCcy.format(double);
  }

  static double foodPrice(
      {required bool isDiscount,
      required double foodPrice,
      required int discount}) {
    double discountAmount = (foodPrice * discount.toDouble()) / 100;
    double discountedPrice = foodPrice - discountAmount;

    return isDiscount ? discountedPrice : foodPrice;
  }
}
