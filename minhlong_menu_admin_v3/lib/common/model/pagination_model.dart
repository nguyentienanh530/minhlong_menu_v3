import 'package:freezed_annotation/freezed_annotation.dart';
part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';

@freezed
class PaginationModel with _$PaginationModel {
  factory PaginationModel({
    @Default(0) int page,
    @Default(0) int limit,
    @Default(0) @JsonKey(name: 'total_page') int totalPage,
    @Default(0) @JsonKey(name: 'total_item') int totalItem,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}
