part of 'cafe_list_bloc.dart';

abstract class CafeListState {
  const CafeListState();
}

@freezed
class CafeListEmpty extends CafeListState with _$CafeListEmpty {
  const factory CafeListEmpty() = _CafeListEmpty;
}

@freezed
class CafeListLoading extends CafeListState with _$CafeListLoading {
  const factory CafeListLoading() = _CafeListLoading;
}

@freezed
class CafeListLoadingFinished extends CafeListState
    with _$CafeListLoadingFinished {
  const factory CafeListLoadingFinished(
      {@Default([]) List<CafeDetail> cafeList}) = _CafeListLoadingFinished;
}

@freezed
class CafeListLoadingError extends CafeListState with _$CafeListLoadingError {
  const factory CafeListLoadingError() = _CafeListLoadingError;
}
