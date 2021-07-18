import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDb {
  Future<void> initLocalDb() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  static void registerAdapters() {
    //cafe_detail
    Hive.registerAdapter(CafeDetailAdapter());
    Hive.registerAdapter(PhotoAdapter());
    Hive.registerAdapter(CoordinateAdapter());
    Hive.registerAdapter(GeometryAdapter());
    Hive.registerAdapter(OpeningHoursAdapter());

    //cafe_review
    Hive.registerAdapter(ReviewAdapter());
    Hive.registerAdapter(ReviewDetailAdapter());
    Hive.registerAdapter(ReviewByCheckboxAdapter());
    Hive.registerAdapter(ReviewByWritingAdapter());
    Hive.registerAdapter(ReviewByRatingAdapter());
    Hive.registerAdapter(ReviewByPhotoAdapter());
  }

  void closeLocalDb() {
    Hive.close();
  }
}
