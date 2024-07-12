import '../../../models/food.dart';

class FoodRepository {
  FoodRepository._internal();
  static final FoodRepository _instance = FoodRepository._internal();
  factory FoodRepository() => _instance;
  // Future getFoods() async {
  //   var foods = await Food().query().where('is_show', '=', 1).get();
  //   return foods;
  // }

  Future get({required int startIndex, required int limit}) async {
    var foods = await Food()
        .query()
        .select(['food.*', 'category.name as category_name'])
        .offset(startIndex)
        .limit(limit)
        .join('category', 'category.id', '=', 'food.category_id')
        .orderBy('created_at', 'desc')
        .get();
    return foods;
  }

  Future getFoods({int? limit, required String byProperty}) async {
    List<Map<String, dynamic>> foods;
    if (limit != null) {
      foods = await Food()
          .query()
          .where('is_show', '=', 1)
          .orderBy(byProperty, 'desc')
          .limit(int.parse(limit.toString()))
          .get();
    } else {
      foods = await Food()
          .query()
          .where('is_show', '=', 1)
          .orderBy(byProperty, 'desc')
          .get();
    }

    return foods;
  }

  Future getQuantityOfFood() async {
    var quantity = await Food().query().count();
    return quantity;
  }

  Future update({required int id, required Map<String, dynamic> data}) async {
    return await Food().query().where('id', '=', id).update(data);
  }

  Future find({required int id}) async {
    return await Food().query().where('id', '=', id).first();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await Food().query().insertGetId(data);
  }

  Future foodCount() async {
    return await Food().query().count();
  }

  Future delete({required int id}) async {
    return await Food().query().where('id', '=', id).delete();
  }

  Future search({required String query}) async {
    var foods =
        await Food().query().limit(10).where('name', 'like', '%$query%').get();
    return foods;
  }
}
