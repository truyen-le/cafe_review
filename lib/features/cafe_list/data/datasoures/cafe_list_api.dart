import 'package:cafe_review/core/network/dio_client.dart';
import 'package:cafe_review/features/cafe_detail/data/data.dart';

class CafeListApi {
  final DioClient _dioClient;
  final String _searchUrl;
  final String _key;

  CafeListApi(this._dioClient, this._searchUrl, this._key);

  Future<List<CafeDetail>> fetchCafeList(double lat, double lng) async {
    final Map<String, dynamic> queryParameters = {
      'key': _key,
      'location': '$lat,$lng',
      'type': 'cafe',
      'rankby': 'distance',
      'fields': 'place_id,photos,formatted_address,name,rating,types',
    };
    try {
      final res =
          await _dioClient.get(_searchUrl, queryParameters: queryParameters);
      if (res['status'] != 'OK') throw Exception(res['status']);
      List<CafeDetail> ls = [];
      res['results'].forEach((cafe) {
        ls.add(CafeDetail.fromJson(cafe));
      });
      return ls;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
