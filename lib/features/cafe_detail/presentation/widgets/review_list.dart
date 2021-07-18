import 'dart:io';

import 'package:cafe_review/constant/colors.dart';
import 'package:cafe_review/core/widgets/take_picture.dart';
import 'package:cafe_review/features/cafe_detail/cafe_detail.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewList extends StatelessWidget {
  final Review review;

  const ReviewList({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: review.details.length,
      itemBuilder: (_, index) {
        final detail = review.details[index];
        if (detail is ReviewByCheckbox) {
          return _CheckboxReviewTile(
            reviewDetail: detail,
            onChanged: (value) {
              context.read<CafeDetailBloc>().add(CafeDetailChangeReviewAt(
                    reviewDetail: detail.copyWith(isChecked: value ?? false),
                    index: index,
                  ));
              context
                  .read<CafeDetailBloc>()
                  .add(CafeDetailCheckReviewCompletion());
            },
          );
        }
        if (detail is ReviewByWriting) {
          return _WritingReviewTile(
            reviewDetail: detail,
            onChange: (value) =>
                context.read<CafeDetailBloc>().add(CafeDetailChangeReviewAt(
                      reviewDetail: detail.copyWith(content: value),
                      index: index,
                    )),
            onOutFocus: () => context
                .read<CafeDetailBloc>()
                .add(CafeDetailCheckReviewCompletion()),
          );
        }
        if (detail is ReviewByRating) {
          return _RatingReviewTile(
            reviewDetail: detail,
            onRatingUpdate: (value) {
              context.read<CafeDetailBloc>().add(CafeDetailChangeReviewAt(
                    reviewDetail: detail.copyWith(rating: value),
                    index: index,
                  ));
              context
                  .read<CafeDetailBloc>()
                  .add(CafeDetailCheckReviewCompletion());
            },
          );
        }
        if (detail is ReviewByPhoto) {
          return _PhotoReviewTile(
            reviewDetail: detail,
            onPhotoTaken: (path) {
              context.read<CafeDetailBloc>().add(CafeDetailChangeReviewAt(
                    reviewDetail: detail.copyWith(path: path),
                    index: index,
                  ));
              context
                  .read<CafeDetailBloc>()
                  .add(CafeDetailCheckReviewCompletion());
            },
          );
        }
        return Container();
      },
    );
  }
}

class _CheckboxReviewTile extends StatelessWidget {
  final ReviewByCheckbox reviewDetail;
  final ValueChanged<bool?>? onChanged;

  const _CheckboxReviewTile(
      {Key? key, required this.reviewDetail, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: CheckboxListTile(
          value: reviewDetail.isChecked,
          title: Text(
            reviewDetail.title,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _WritingReviewTile extends StatelessWidget {
  final ReviewByWriting reviewDetail;
  final ValueChanged<String>? onChange;
  final VoidCallback? onOutFocus;

  const _WritingReviewTile({
    Key? key,
    required this.reviewDetail,
    this.onChange,
    this.onOutFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${reviewDetail.title}',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Focus(
              child: TextFormField(
                initialValue: reviewDetail.content,
                maxLines: 4,
                minLines: 1,
                onChanged: onChange,
              ),
              onFocusChange: (focus) {
                if (onOutFocus != null && !focus) {
                  onOutFocus!();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class _RatingReviewTile extends StatelessWidget {
  final ReviewByRating reviewDetail;
  final ValueChanged<double> onRatingUpdate;

  const _RatingReviewTile({
    Key? key,
    required this.reviewDetail,
    required this.onRatingUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${reviewDetail.title}',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Center(
              child: RatingBar.builder(
                initialRating: reviewDetail.rating,
                minRating: 0.5,
                maxRating: 5,
                itemCount: 5,
                allowHalfRating: true,
                direction: Axis.horizontal,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (_, index) => Icon(
                  Icons.star,
                  color: AppColors.secondary,
                ),
                onRatingUpdate: onRatingUpdate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoReviewTile extends StatelessWidget {
  final ReviewByPhoto reviewDetail;
  final ValueChanged<String>? onPhotoTaken;

  const _PhotoReviewTile({
    Key? key,
    required this.reviewDetail,
    this.onPhotoTaken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${reviewDetail.title}',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.34),
                    child: reviewDetail.path == null
                        ? Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.primary,
                              size: 32.0,
                            ),
                          )
                        : Image.file(
                            File(reviewDetail.path!),
                            fit: BoxFit.cover,
                          ),
                    onTap: () async {
                      // Obtain a list of the available cameras on the device.
                      final cameras = await availableCameras();

                      // Get a specific camera from the list of available cameras.
                      final firstCamera = cameras.first;

                      final path = await Navigator.push(
                          context, TakePictureScreen.route(firstCamera));
                      if (path != null && onPhotoTaken != null) {
                        onPhotoTaken!(path);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
