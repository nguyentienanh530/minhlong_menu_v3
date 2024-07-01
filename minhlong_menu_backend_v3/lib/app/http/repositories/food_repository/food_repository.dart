import '../../../models/food.dart';

class FoodRepository {
  FoodRepository._internal();
  static final FoodRepository _instance = FoodRepository._internal();
  factory FoodRepository() => _instance;
  Future getFoods() async {
    var foods = await Food().query().where('is_show', '=', 1).get();
    return foods;
  }

  Future getPopularFoods() async {
    var foods = await Food()
        .query()
        .where('is_show', '=', 1)
        .orderBy('order_count', 'desc')
        .get();
    return foods;
  }

  Future getNewFoodsOnLimit(int limit) async {
    var foods = await Food()
        .query()
        .where('is_show', '=', 1)
        .orderBy('created_at', 'desc')
        .limit(limit)
        .get();
    return foods;
  }

  Future getNewFoods() async {
    var foods = await Food()
        .query()
        .where('is_show', '=', 1)
        .orderBy('created_at', 'desc')
        .get();
    return foods;
  }

  Future getQuantityOfFood() async {
    var quantity = await Food().query().count();
    return quantity;
  }
}