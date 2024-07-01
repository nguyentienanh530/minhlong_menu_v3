import 'package:vania/vania.dart';

class CreateTableTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('table', () {
      id();
      string('name');
      integer('seats');
      addColumn('is_use', 'boolean');
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('table');
  }
}
