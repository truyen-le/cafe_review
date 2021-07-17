import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:cafe_review/features/cafe_list/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cafe_list_bloc.freezed.dart';
part 'cafe_list_event.dart';
part 'cafe_list_state.dart';

class CafeListBloc extends Bloc<CafeListEvent, CafeListState> {
  final CafeListRepositories _repositories;

  CafeListBloc(this._repositories) : super(CafeListEmpty());

  @override
  Stream<CafeListState> mapEventToState(CafeListEvent event) async* {
    if (event is CafeListRequestNewList) {
      yield* _mapCafeListRequestNewListToState(event, state);
    }
  }

  Stream<CafeListState> _mapCafeListRequestNewListToState(
      CafeListRequestNewList event, CafeListState state) async* {
    yield CafeListLoading();
    try {
      final cafeList = await _repositories.fetchCafeList(event.lat, event.lng);
      yield CafeListLoadingFinished(cafeList: cafeList);
    } catch (e) {
      yield CafeListLoadingError();
    }
  }
}
