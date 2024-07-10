import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';

import '../../../../common/model/pagination_model.dart';
part 'table_model.freezed.dart';
part 'table_model.g.dart';

@freezed
class TableModel with _$TableModel {
  factory TableModel({
    @JsonKey(name: 'pagination') final PaginationModel? paginationModel,
    @Default(<TableItem>[]) @JsonKey(name: 'data') List<TableItem> tableItems,
  }) = _TableModel;

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);
}
