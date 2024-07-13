import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/model/banner_item.dart';

import '../../../../common/model/pagination_model.dart';
part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
class BannerModel with _$BannerModel {
  factory BannerModel({
    @JsonKey(name: 'pagination') final PaginationModel? paginationModel,
    @Default(<BannerItem>[])
    @JsonKey(name: 'data')
    List<BannerItem> bannerItems,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
