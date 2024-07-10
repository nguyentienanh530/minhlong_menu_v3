import 'package:flutter/material.dart';

class AppKeys {
  static const riKey1 = Key('____');

  static GlobalKey<FormState> createOrUpdateKey =
      GlobalKey<FormState>(debugLabel: '__createOrUpdateKey__');

  static GlobalKey<FormState> searchKey =
      GlobalKey<FormState>(debugLabel: 'searchKey');
}
