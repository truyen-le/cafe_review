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
      yield* _mapCafeDetailAddNewReviewToState(event, state);
    } else if (event is CafeDetailChangeReviewAt) {
      yield _mapCafeDetailChangeReviewAtToState(event, state);
    } else if (event is CafeDetailCheckReviewCompletion) {
      yield* _mapCafeDetailCheckReviewCompletionToState(event, state);
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

  Stream<CafeDetailState> _mapCafeDetailAddNewReviewToState(
      CafeDetailAddNewReview event, CafeDetailState state) async* {
    if (state is CafeDetailLoadingFinished) {
      final reviewDetails = state.review.details.toList();
      reviewDetails.add(event.reviewDetail);
      await _repositories.saveReview(
          state.review.copyWith(details: reviewDetails, completed: false));
      yield state.copyWith.review(details: reviewDetails, completed: false);
    } else {
      throw Exception('Event is used in wrong state: ${state.runtimeType}');
    }
  }

  CafeDetailState _mapCafeDetailChangeReviewAtToState(
      CafeDetailChangeReviewAt event, CafeDetailState state) {
    if (state is CafeDetailLoadingFinished) {
      final reviewDetails = state.review.details.toList();
      reviewDetails[event.index] = event.reviewDetail;
      return state.copyWith.review(details: reviewDetails);
    }
    throw Exception('Event is used in wrong state: ${state.runtimeType}');
  }

  Stream<CafeDetailState> _mapCafeDetailCheckReviewCompletionToState(
      CafeDetailCheckReviewCompletion event, CafeDetailState state) async* {
    if (state is CafeDetailLoadingFinished) {
      bool completed = true;

      for (var element in state.review.details) {
        ///Do not check the checkbox since when apply to a yes/no question
        ///checkbox can answer yes/no choices but no the have not answer choice
        ///default will be false which assume the user answer no
        ///this only base on review app context
        // if (element is ReviewByCheckbox) {
        //   if (!element.isChecked) {
        //     completed = false;
        //     break;
        //   }
        // }
        if (element is ReviewByWriting) {
          if (element.content == '') {
            completed = false;
            break;
          }
        }
        if (element is ReviewByRating) {
          if (element.rating == 0.0) {
            completed = false;
            break;
          }
        }
        if (element is ReviewByPhoto) {
          if (element.path == null || element.path == '') {
            completed = false;
            break;
          }
        }
      }
      await _repositories
          .saveReview(state.review.copyWith(completed: completed));
      yield state.copyWith.review(completed: completed);
    } else {
      throw Exception('Event is used in wrong state: ${state.runtimeType}');
    }
  }
}
