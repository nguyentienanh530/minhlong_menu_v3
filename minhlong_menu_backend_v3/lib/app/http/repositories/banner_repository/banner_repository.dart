import '../../../models/banner.dart';

class BannerRepository {
  Future getAll() async {
    return await Banner().query().get();
  }

  Future get({required int startIndex, required int limit}) async {
    return await Banner()
        .query()
        .offset(startIndex)
        .limit(limit)
        .orderBy('created_at', 'desc')
        .get();
  }

  Future bannerCount() async {
    return await Banner().query().count();
  }
}
