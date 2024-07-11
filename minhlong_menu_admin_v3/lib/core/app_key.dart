import 'package:flutter/material.dart';

class AppKeys {
  static GlobalKey<FormState> createOrUpdateKey =
      GlobalKey<FormState>(debugLabel: 'createOrUpdateKey');

  static GlobalKey<FormState> searchKey =
      GlobalKey<FormState>(debugLabel: 'searchKey');

  static GlobalKey<FormState> createOrUpdateDinnerTableKey =
      GlobalKey<FormState>(debugLabel: 'createOrUpdateDinnerTableKey');

  static GlobalKey<FormState> createOrUpdateCategoryKey =
      GlobalKey<FormState>(debugLabel: 'createOrUpdateCategoryKey');
}
