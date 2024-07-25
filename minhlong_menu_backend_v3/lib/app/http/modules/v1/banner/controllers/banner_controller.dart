import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';
import '../repositories/banner_repository.dart';
part '_create_banner.dart';
part '_index_banner.dart';
part '_update_banner.dart';
part '../controllers/_destroy_banner.dart';

class BannerController extends Controller {
  final BannerRepository _bannerRepository;

  BannerController({required BannerRepository bannerRepository})
      : _bannerRepository = bannerRepository;

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }
}
