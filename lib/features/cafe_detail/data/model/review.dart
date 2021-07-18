import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'review.freezed.dart';
part 'review.g.dart';

enum ReviewType {
  checkbox,
  write,
  rating,
  picture,
}

extension SortTypeValue on ReviewType {
  String get label {
    switch (this) {
      case ReviewType.checkbox:
        return 'Checkbox';
      case ReviewType.write:
        return 'Write a review';
      case ReviewType.rating:
        return 'Add a rating';
      case ReviewType.picture:
        return 'Take a picture';
      default:
        return 'Unknown';
    }
  }
}

@freezed
class Review with _$Review {
  @HiveType(typeId: 6, adapterName: 'ReviewAdapter')
  const factory Review({
    @HiveField(0) required String placeId,
    @HiveField(1) @Default(false) bool completed,
    @HiveField(2) @Default([]) List<ReviewDetail> details,
  }) = _Review;
}

@freezed
class ReviewDetail with _$ReviewDetail {
  const ReviewDetail._();
  @HiveType(typeId: 7, adapterName: 'ReviewDetailAdapter')
  const factory ReviewDetail() = _ReviewDetail;
}

@freezed
class ReviewByCheckbox extends ReviewDetail with _$ReviewByCheckbox {
  @HiveType(typeId: 8, adapterName: 'ReviewByCheckboxAdapter')
  const factory ReviewByCheckbox({
    @HiveField(0) required String title,
    @HiveField(1) required bool isChecked,
  }) = _ReviewByCheckbox;
}

@freezed
class ReviewByWriting extends ReviewDetail with _$ReviewByWriting {
  @HiveType(typeId: 9, adapterName: 'ReviewByWritingAdapter')
  const factory ReviewByWriting({
    @HiveField(0) required String title,
    @HiveField(1) required String content,
  }) = _ReviewByWriting;
}

@freezed
class ReviewByRating extends ReviewDetail with _$ReviewByRating {
  @HiveType(typeId: 10, adapterName: 'ReviewByRatingAdapter')
  const factory ReviewByRating({
    @HiveField(0) required String title,
    @HiveField(1) required double rating,
  }) = _ReviewByRating;
}

@freezed
class ReviewByPhoto extends ReviewDetail with _$ReviewByPhoto {
  @HiveType(typeId: 11, adapterName: 'ReviewByPhotoAdapter')
  const factory ReviewByPhoto({
    @HiveField(0) required String title,
    @HiveField(1) String? path,
  }) = _ReviewByPhoto;
}
