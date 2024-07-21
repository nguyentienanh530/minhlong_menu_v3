import 'dart:async';

import '../models/foods.dart';

class FoodRepository {
  final Foods _food;

  FoodRepository({required Foods food}) : _food = food;

  Future get(
      {required String byProperty,
      required int startIndex,
      required int limit,
      required int userID}) async {
    var foods = await _food
        .query()
        .select(['foods.*', 'categories.name as category_name'])
        .offset(startIndex)
        .limit(limit)
        .join('categories', 'categories.id', '=', 'foods.category_id')
        .orderBy(byProperty, 'desc')
        .where('foods.user_id', '=', userID)
        .get();
    return foods;
  }

  Future getAll({required int userID}) async {
    var foods = await _food
        .query()
        .select(['foods.*', 'categories.name as category_name'])
        .join('categories', 'categories.id', '=', 'foods.category_id')
        .where('foods.user_id', '=', userID)
        .orderBy('created_at', 'desc')
        .get();
    return foods;
  }

  Future getFoodsOnCategory(
      {required int startIndex,
      required int limit,
      required int categoryID,
      required int userID}) async {
    var foods = await _food
        .query()
        .offset(startIndex)
        .where('is_show', '=', 1)
        .where('category_id', '=', categoryID)
        .where('user_id', '=', userID)
        .limit(limit)
        .get();
    return foods;
  }

  Future foodsCountOnCategory(
      {required int categoryID, required int userID}) async {
    var count = await _food
        .query()
        .where('is_show', '=', 1)
        .where('category_id', '=', categoryID)
        .where('user_id', '=', userID)
        .count();
    return count;
  }

  Future getTotalNumberOfFoods({required int userID}) async {
    var quantity = await _food.query().where('user_id', '=', userID).count();
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

  Future foodCount({required int userID}) async {
    return await _food.query().where('user_id', '=', userID).count();
  }

  Future delete({required int id}) async {
    return await _food.query().where('id', '=', id).delete();
  }

  Future search({required String query, required int userID}) async {
    var foods = await _food
        .query()
        .limit(10)
        .where('user_id', '=', userID)
        .where('name', 'like', '%$query%')
        .get();
    return foods;
  }

  //get best selling food
  Future getBestSellingFood({required int userID}) async {
    var foods = await _food
        .query()
        .select(['foods.order_count as order_count', 'foods.name as name'])
        .where('foods.user_id', '=', userID)
        .orderBy('order_count', 'desc')
        .limit(4)
        .get();
    return foods;
  }
}
