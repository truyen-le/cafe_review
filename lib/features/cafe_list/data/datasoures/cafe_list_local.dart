import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:hive/hive.dart';

class CafeListLocal {
  final String boxName;
  final Future<Box> _box;

  CafeListLocal({this.boxName = 'cafe_list'}) : _box = Hive.openBox(boxName);

  Future<List<CafeDetail>> getCafeList() async {
    final box = await _box;
    return box.get('nearby_list');
  }

  Future<void> saveCafeList(List<CafeDetail> cafeList) async {
    final box = await _box;
    box.put('nearby_list', cafeList);
  }
}
