import 'package:vania/vania.dart';

class CreateCategoryTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('category', () {
      id();
      string('name', length: 50);
      string('image', nullable: true);
      integer('serial');
      timeStamp('created_at', nullable: true);
      timeStamp('updated_at', nullable: true);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('category');
  }
}
