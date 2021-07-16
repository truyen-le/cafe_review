import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDb {
  Future<void> initLocalDb() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  void closeLocalDb() {
    Hive.close();
  }
}
