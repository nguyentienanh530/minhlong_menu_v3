import 'package:vania/vania.dart';

class CreateFoodTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('food', () {
      id();
      string('name');
      bigInt('category_id', unsigned: true);
      bigInt('order_count', nullable: true);
      longText('description', nullable: true);
      string('photo_gallery', nullable: true);
      integer('discount', nullable: true);
      addColumn('isDiscount', 'boolean');
      addColumn('isShow', 'boolean');
      float('price', precision: 8, scale: 2);
      timeStamps();
      foreign('category_id', 'category', 'id',
          constrained: true, onDelete: 'CASCADE');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('food');
  }
}
