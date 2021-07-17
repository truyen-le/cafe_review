import 'package:cafe_review/features/cafe_detail/data/data.dart';

class CafeDetailRepositories {
  final CafeDetailApi _api;
  final CafeDetailLocal _local;

  CafeDetailRepositories(this._api, this._local);

  Future<CafeDetail> fetchCafeDetail(String placeId) async {
    return _api.fetchCafeDetail(placeId).then((cafeDetail) {
      _local.saveCafeDetail(cafeDetail);
      return cafeDetail;
    }).catchError((error) => throw error);
  }

  Future<CafeDetail?> getCafeDetail(String placeId) async {
    return _local.getCafeDetail(placeId);
  }

  Future<Review?> getReview(String placeId) async {
    return _local.getReview(placeId);
  }

  Future<void> saveReview(Review review) async {
    _local.saveReview(review);
  }
}
