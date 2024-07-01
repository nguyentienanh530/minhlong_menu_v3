import 'package:vania/vania.dart';

class CreateOrderDetailTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('order_detail', () {
      id();
      bigInt('order_id', unsigned: true);
      bigInt('food_id', unsigned: true);
      integer('quantity');
      float('price', precision: 8, scale: 2);
      timeStamps();
      foreign('food_id', 'food', 'id', onDelete: 'CASCADE', constrained: true);
      foreign('order_id', 'order', 'id',
          constrained: true, onDelete: 'CASCADE');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('order_detail');
  }
}
