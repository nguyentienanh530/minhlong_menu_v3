import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minhlong_menu_admin_v3/common/model/pagination_model.dart';

import 'category_item.dart';
part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  factory CategoryModel({
    @JsonKey(name: 'pagination') PaginationModel? paginationModel,
    @Default(<CategoryItem>[])
    @JsonKey(name: 'data')
    List<CategoryItem> categoryItems,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
