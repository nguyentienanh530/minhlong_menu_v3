import 'package:vania/vania.dart';

class CreateBannerTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('banner', () {
      id();
      string('image');
      timeStamp('created_at', nullable: true);
      timeStamp('updated_at', nullable: true);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('banner');
  }
}
