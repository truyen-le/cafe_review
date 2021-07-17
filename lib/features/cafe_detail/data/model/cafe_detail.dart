import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'cafe_detail.freezed.dart';
part 'cafe_detail.g.dart';

@freezed
class CafeDetail with _$CafeDetail {
  @HiveType(typeId: 1, adapterName: 'CafeDetailAdapter')
  const factory CafeDetail({
    @JsonKey(name: 'place_id', required: true)
    @HiveField(0)
        required String placeId,
    @JsonKey(name: 'name', required: true) @HiveField(1) required String name,
    @JsonKey(name: 'formatted_address', disallowNullValue: true)
    @HiveField(2)
        String? address,
    @JsonKey(name: 'formatted_phone_number', disallowNullValue: true)
    @HiveField(3)
        String? phoneNumber,
    @JsonKey(name: 'rating', disallowNullValue: true)
    @HiveField(4)
    @Default(0.0)
        double? rating,
    @JsonKey(name: 'icon', disallowNullValue: true) @HiveField(5) String? icon,
    @JsonKey(name: 'photos', disallowNullValue: true)
    @HiveField(6)
        List<Photo>? photos,
    @JsonKey(name: 'geometry', required: true)
    @HiveField(7)
        required Geometry geometry,
    @JsonKey(name: 'vicinity') @HiveField(8) String? vicinity,
    @JsonKey(name: 'opening_hours') @HiveField(9) OpeningHours? openingHours,
  }) = _CafeDetail;

  factory CafeDetail.fromJson(Map<String, dynamic> json) =>
      _$CafeDetailFromJson(json);
}

@freezed
class Photo with _$Photo {
  @HiveType(typeId: 2, adapterName: 'PhotoAdapter')
  const factory Photo({
    @JsonKey(name: 'photo_reference', required: true)
    @HiveField(0)
        required String reference,
    @JsonKey(name: 'width') @HiveField(1) @Default(600) double width,
    @JsonKey(name: 'height') @HiveField(2) @Default(330) double height,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@freezed
class Coordinate with _$Coordinate {
  @HiveType(typeId: 3, adapterName: 'CoordinateAdapter')
  const factory Coordinate({
    @JsonKey(name: 'lat', required: true)
    @HiveField(0)
        required double latitude,
    @JsonKey(name: 'lng', required: true)
    @HiveField(1)
        required double longitude,
  }) = _Coordinate;

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);
}

@freezed
class Geometry with _$Geometry {
  @HiveType(typeId: 4, adapterName: 'GeometryAdapter')
  const factory Geometry({
    @JsonKey(name: 'location', required: true)
    @HiveField(0)
        required Coordinate location,
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@freezed
class OpeningHours with _$OpeningHours {
  @HiveType(typeId: 5, adapterName: 'OpeningHoursAdapter')
  const factory OpeningHours({
    @JsonKey(name: 'open_now') @HiveField(0) bool? openNow,
  }) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);
}
