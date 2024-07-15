import 'dart:async';

import '../models/food.dart';

class FoodRepository {
  final Food _food;

  FoodRepository({required Food food}) : _food = food;

  Future get(
      {required String byProperty,
      required int startIndex,
      required int limit}) async {
    var foods = await _food
        .query()
        .select(['food.*', 'category.name as category_name'])
        .offset(startIndex)
        .limit(limit)
        .join('category', 'category.id', '=', 'food.category_id')
        .orderBy(byProperty, 'desc')
        .get();
    return foods;
  }

  Future getFoodsOnCategory(
      {required int startIndex, required int limit, required int id}) async {
    var foods = await _food
        .query()
        .offset(startIndex)
        .where('is_show', '=', 1)
        .where('category_id', '=', id)
        .limit(limit)
        .get();
    return foods;
  }

  Future foodsCountOnCategory({required int id}) async {
    var count = await _food
        .query()
        .where('is_show', '=', 1)
        .where('category_id', '=', id)
        .count();
    return count;
  }

  Future getQuantityOfFood() async {
    var quantity = await _food.query().count();
    return quantity;
  }

  Future update({required int id, required Map<String, dynamic> data}) async {
    return await _food.query().where('id', '=', id).update(data);
  }

  Future find({required int id}) async {
    return await _food.query().where('id', '=', id).first();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await _food.query().insertGetId(data);
  }

  Future foodCount() async {
    return await _food.query().count();
  }

  Future delete({required int id}) async {
    return await _food.query().where('id', '=', id).delete();
  }

  Future search({required String query}) async {
    var foods =
        await _food.query().limit(10).where('name', 'like', '%$query%').get();
    return foods;
  }
}
