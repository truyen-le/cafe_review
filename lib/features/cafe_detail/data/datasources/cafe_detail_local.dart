import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:hive/hive.dart';

class CafeDetailLocal {
  final String boxName;
  final Future<Box> _box;

  CafeDetailLocal({this.boxName = 'cafe_detail'})
      : _box = Hive.openBox(boxName);

  Future<CafeDetail?> getCafeDetail(String placeId) async {
    final box = await _box;
    return box.get('detail_$placeId');
  }

  Future<void> saveCafeDetail(CafeDetail cafeDetail) async {
    final box = await _box;
    box.put('detail_${cafeDetail.placeId}', cafeDetail);
  }

  Future<Review?> getReview(String placeId) async {
    final box = await _box;
    return box.get('review_$placeId');
  }

  Future<void> saveReview(Review review) async {
    final box = await _box;
    box.put('review_${review.placeId}', review);
  }
}
