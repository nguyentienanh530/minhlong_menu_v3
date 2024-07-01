import 'package:vania/vania.dart';

class CreateOrderTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('order', () {
      id();
      bigInt('table_id', unsigned: true);
      string('status');
      float('total_price', precision: 8, scale: 2);
      timeStamp('payed_at', nullable: true);
      timeStamps();
      index(ColumnIndex.indexKey, 'status', ['status']);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('order');
  }
}
