part of 'cafe_detail_bloc.dart';

abstract class CafeDetailState {
  const CafeDetailState();
}

@freezed
class CafeDetailEmpty extends CafeDetailState with _$CafeDetailEmpty {
  const factory CafeDetailEmpty() = _CafeDetailEmpty;
}

@freezed
class CafeDetailLoading extends CafeDetailState with _$CafeDetailLoading {
  const factory CafeDetailLoading() = _CafeDetailLoading;
}

@freezed
class CafeDetailLoadingFinished extends CafeDetailState
    with _$CafeDetailLoadingFinished {
  const factory CafeDetailLoadingFinished(
      {required CafeDetail detail,
      required Review review}) = _CafeDetailLoadingFinished;
}

@freezed
class CafeDetailLoadingError extends CafeDetailState
    with _$CafeDetailLoadingError {
  const factory CafeDetailLoadingError() = _CafeDetailLoadingError;
}
