import 'dart:io';

// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Ultils {
  // Future<dynamic> pickImage() async {
  //   dynamic imageFile;
  //   final imagePicker = ImagePicker();
  //   var imagepicked = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (imagepicked != null) {
  //     imageFile = File(imagepicked.path);

  //     Logger().d('Image Path: ${imageFile.path}');
  //   } else {
  //     Logger().d('No image selected!');
  //   }
  //   return imageFile;
  // }

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
