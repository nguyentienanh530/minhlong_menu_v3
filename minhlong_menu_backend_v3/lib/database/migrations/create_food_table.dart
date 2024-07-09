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
      text('image1');
      text('image2');
      text('image3');
      text('image4');
      integer('discount', nullable: true);
      addColumn('isDiscount', 'boolean');
      addColumn('isShow', 'boolean');
      float('price');
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
