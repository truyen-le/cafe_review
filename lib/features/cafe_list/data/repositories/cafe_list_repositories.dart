import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:cafe_review/features/cafe_list/data/data.dart';

class CafeListRepositories {
  final CafeListApi _api;
  final CafeListLocal _local;

  CafeListRepositories(this._api, this._local);

  Future<List<CafeDetail>> fetchCafeList(double lat, double lng) async {
    return _api.fetchCafeList(lat, lng).then((cafeList) {
      _local.saveCafeList(cafeList);
      return cafeList;
    }).catchError((error) => throw error);
  }

  Future<List<CafeDetail>> getCafeList() async {
    return _local.getCafeList();
  }
}
