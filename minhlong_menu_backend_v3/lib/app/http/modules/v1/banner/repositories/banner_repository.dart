import '../models/banners.dart';

class BannerRepository {
  final Banner _banner;
  BannerRepository({required Banner banner}) : _banner = banner;
  Future getAll() async {
    return await _banner.query().get();
  }

  Future get({required int startIndex, required int limit}) async {
    return await _banner
        .query()
        .offset(startIndex)
        .limit(limit)
        .orderBy('created_at', 'desc')
        .get();
  }

  Future bannerCount() async {
    return await _banner.query().count();
  }

  Future delete({required int id}) async {
    return await _banner.query().where('id', '=', id).delete();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await _banner.query().insertGetId(data);
  }

  Future update({required int id, required Map<String, dynamic> data}) async {
    return await _banner.query().where('id', '=', id).update(data);
  }

  Future find({required int id}) async {
    return await _banner.query().where('id', '=', id).first();
  }
}
