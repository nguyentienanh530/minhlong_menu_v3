import 'package:flutter/material.dart';
import '../../../category/data/model/category_model.dart';

enum ModeScreen { foodsOnCategory, foods }

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key, this.category, required this.modeScreen});
  final CategoryModel? category;
  final ModeScreen modeScreen;

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    if (widget.modeScreen == ModeScreen.foodsOnCategory) {
      // categoryModel = widget.category!;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column());
  }
}
