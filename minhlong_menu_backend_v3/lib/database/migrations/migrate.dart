import 'dart:io';
import 'package:vania/vania.dart';
import 'create_banner_table.dart';
import 'create_order_detail_table.dart';
import 'create_user_table.dart';
import 'create_personal_access_tokens_table.dart';
import 'create_category_table.dart';
import 'create_food_table.dart';
import 'create_table_table.dart';
import 'create_order_table.dart';

void main() async {
  await MigrationConnection().setup();
  await Migrate().registry();
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
    await CreateUserTable().up();
    await CreateBannerTable().up();
    await CreatePersonalAccessTokensTable().up();
    await CreateCategoryTable().up();
    await CreateFoodTable().up();
    await CreateTableTable().up();
    await CreateOrderTable().up();
    await CreateOrderDetailTable().up();
  }

  dropTables() async {
    await CreateUserTable().down();
    await CreateBannerTable().down();
    await CreatePersonalAccessTokensTable().down();
    await CreateCategoryTable().down();
    await CreateFoodTable().down();
    await CreateTableTable().down();
    await CreateOrderTable().down();
    await CreateOrderDetailTable().down();
  }
}
