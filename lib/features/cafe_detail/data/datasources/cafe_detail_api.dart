import 'package:cafe_review/core/network/dio_client.dart';
import 'package:cafe_review/features/cafe_detail/data/data.dart';

class CafeDetailApi {
  final DioClient _dioClient;
  final String _detailUrl;
  final String _key;

  const CafeDetailApi(this._dioClient, this._detailUrl, this._key);

  Future<CafeDetail> fetchCafeDetail(String placeId) async {
    final Map<String, dynamic> queryParameters = {
      'key': _key,
      'place_id': placeId,
    };
    try {
      final res =
          await _dioClient.get(_detailUrl, queryParameters: queryParameters);
      if (res['status'] != 'OK') throw Exception(res['status']);
      return CafeDetail.fromJson(res['result']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
