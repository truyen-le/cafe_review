import 'package:flutter_dotenv/flutter_dotenv.dart';

String getApiKey() {
  final value = dotenv.env['MAP_API_KEY'];
  if (value == null) throw Exception('Cannot find API Key in .env file');
  return dotenv.env['MAP_API_KEY']!;
}

const ROOT_URL = 'https://maps.googleapis.com/maps/api/place';

const NEAR_BY = '$ROOT_URL/nearbysearch/json';

const DETAIL = '$ROOT_URL/details/json';

const PHOTO = '$ROOT_URL/photo';
