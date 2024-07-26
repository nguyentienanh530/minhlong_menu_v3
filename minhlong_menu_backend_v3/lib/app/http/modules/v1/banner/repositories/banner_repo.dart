import '../models/banners.dart';

class BannerRepo {
  final Banners banner;
  BannerRepo(this.banner);
  Future getAllForUsers({required int userID}) async {
    return await banner
        .query()
        .where('user_id', '=', userID)
        .where('show', '=', 1)
        .get();
  }

  Future get(
      {required int startIndex,
      required int limit,
      required int userID}) async {
    return await banner
        .query()
        .offset(startIndex)
        .limit(limit)
        .where('user_id', '=', userID)
        .orderBy('created_at', 'desc')
        .get();
  }

  Future bannerCount({required int userID}) async {
    return await banner.query().where('user_id', '=', userID).count();
  }

  Future delete({required int id}) async {
    return await banner.query().where('id', '=', id).delete();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await banner.query().insertGetId(data);
  }

  Future update({required int id, required Map<String, dynamic> data}) async {
    return await banner.query().where('id', '=', id).update(data);
  }

  Future find({required int id}) async {
    return await banner.query().where('id', '=', id).first();
  }
}
