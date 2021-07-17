import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cafe_detail_bloc.freezed.dart';
part 'cafe_detail_event.dart';
part 'cafe_detail_state.dart';

class CafeDetailBloc extends Bloc<CafeDetailEvent, CafeDetailState> {
  final CafeDetailRepositories _repositories;
  CafeDetailBloc(this._repositories) : super(CafeDetailEmpty());

  @override
  Stream<CafeDetailState> mapEventToState(CafeDetailEvent event) async* {
    if (event is CafeDetailRequest) {
      yield* _mapCafeDetailRequestToState(event, state);
    } else if (event is CafeDetailAddNewReview) {
      yield _mapCafeDetailAddNewReviewToState(event, state);
    }
  }

  Stream<CafeDetailState> _mapCafeDetailRequestToState(
      CafeDetailRequest event, CafeDetailState state) async* {
    yield CafeDetailLoading();
    try {
      final detail = await _repositories.fetchCafeDetail(event.placeId);
      final review = await _repositories.getReview(event.placeId);
      yield CafeDetailLoadingFinished(
          detail: detail, review: review ?? Review(placeId: event.placeId));
    } catch (e) {
      print(e);
      yield CafeDetailLoadingError();
    }
  }

  CafeDetailState _mapCafeDetailAddNewReviewToState(
      CafeDetailAddNewReview event, CafeDetailState state) {
    if (state is CafeDetailLoadingFinished) {
      final reviewDetails = state.review.details.toList();
      reviewDetails.add(event.reviewDetail);
      return state.copyWith(
          review: state.review.copyWith(details: reviewDetails));
    }
    throw Exception('Event is used in wrong state');
  }
}
