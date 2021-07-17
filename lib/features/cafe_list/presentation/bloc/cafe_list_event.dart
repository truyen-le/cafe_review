part of 'cafe_list_bloc.dart';

abstract class CafeListEvent {
  const CafeListEvent();
}

@freezed
class CafeListRequestNewList extends CafeListEvent
    with _$CafeListRequestNewList {
  const factory CafeListRequestNewList(double lat, double lng) =
      _CafeListRequestNewList;
}
