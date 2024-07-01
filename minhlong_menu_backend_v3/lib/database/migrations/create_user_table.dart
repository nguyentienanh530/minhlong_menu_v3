import 'package:vania/vania.dart';

class CreateUserTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('user', () {
      id();
      string('full_name', length: 50);
      integer('phone_number', length: 15);
      string('password');
      string('image', nullable: true);
      timeStamp('created_at', nullable: true);
      timeStamp('updated_at', nullable: true);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('user');
  }
}
