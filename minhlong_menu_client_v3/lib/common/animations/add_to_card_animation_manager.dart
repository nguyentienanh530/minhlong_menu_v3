import 'package:flutter/material.dart';

class AddToCardAnimationManager {
  AddToCardAnimationManager({required this.lenght}) {
    keys = List.generate(lenght, (index) => GlobalKey());
  }
  late final int lenght;
  late var keys = <GlobalKey>[];
}
