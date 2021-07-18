part of 'cafe_detail_bloc.dart';

abstract class CafeDetailEvent {
  const CafeDetailEvent();
}

@freezed
class CafeDetailRequest extends CafeDetailEvent with _$CafeDetailRequest {
  const factory CafeDetailRequest(String placeId) = _CafeDetailRequest;
}

@freezed
class CafeDetailAddNewReview extends CafeDetailEvent
    with _$CafeDetailAddNewReview {
  const factory CafeDetailAddNewReview(ReviewDetail reviewDetail) =
      _CafeDetailAddNewReview;
}

@freezed
class CafeDetailChangeReviewAt extends CafeDetailEvent
    with _$CafeDetailChangeReviewAt {
  const factory CafeDetailChangeReviewAt(
      {required ReviewDetail reviewDetail,
      required int index}) = _CafeDetailChangeReviewAt;
}

@freezed
class CafeDetailCheckReviewCompletion extends CafeDetailEvent
    with _$CafeDetailCheckReviewCompletion {
  const factory CafeDetailCheckReviewCompletion() =
      _CafeDetailCheckReviewCompletion;
}
