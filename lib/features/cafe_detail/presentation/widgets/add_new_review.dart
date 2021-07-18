import 'package:cafe_review/constant/colors.dart';
import 'package:cafe_review/features/cafe_detail/cafe_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewReview extends StatefulWidget {
  const AddNewReview({Key? key}) : super(key: key);

  @override
  _AddNewReviewState createState() => _AddNewReviewState();
}

class _AddNewReviewState extends State<AddNewReview> {
  bool addNew = false;
  String reviewTitle = '';
  ReviewType? reviewType;

  void _addNewReview() {
    if (reviewType != null && reviewTitle != '') {
      switch (reviewType) {
        case ReviewType.checkbox:
          context
              .read<CafeDetailBloc>()
              .add(CafeDetailAddNewReview(ReviewByCheckbox(
                title: reviewTitle,
                isChecked: false,
              )));
          break;
        case ReviewType.write:
          context
              .read<CafeDetailBloc>()
              .add(CafeDetailAddNewReview(ReviewByWriting(
                title: reviewTitle,
                content: '',
              )));
          break;
        case ReviewType.rating:
          context
              .read<CafeDetailBloc>()
              .add(CafeDetailAddNewReview(ReviewByRating(
                title: reviewTitle,
                rating: 0.0,
              )));
          break;
        case ReviewType.picture:
          context
              .read<CafeDetailBloc>()
              .add(CafeDetailAddNewReview(ReviewByPhoto(title: reviewTitle)));
          break;
        default:
          break;
      }
      reviewTitle = '';
      reviewType = null;
      addNew = !addNew;
    }
  }

  Widget _buildButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          addNew = !addNew;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        child: Center(child: Text('ADD NEW REVIEW')),
      ),
    );
  }

  Widget _buildFormBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('What do you want to review?'),
        ),
        TextFormField(
          minLines: 1,
          maxLines: 2,
          onChanged: (value) {
            reviewTitle = value;
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Choose Review Type?'),
        ),
        DropdownButtonFormField(
          value: reviewType,
          dropdownColor: Theme.of(context).backgroundColor,
          decoration: InputDecoration(
            hintText: 'Choose a method',
          ),
          items: <ReviewType>[
            ReviewType.checkbox,
            ReviewType.write,
            ReviewType.rating,
            ReviewType.picture
          ]
              .map<DropdownMenuItem<ReviewType>>(
                  (value) => DropdownMenuItem<ReviewType>(
                        value: value,
                        child: Text(
                          value.label,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ))
              .toList(),
          onChanged: (ReviewType? value) {
            setState(() {
              reviewType = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildFormBottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              setState(() {
                reviewType = null;
                addNew = !addNew;
              });
            },
            child: Center(
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AppColors.error),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: _addNewReview,
            child: Center(
              child: Text(
                'Apply',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Text(
              'New Review',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(),
        _buildFormBody(context),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(),
        ),
        _buildFormBottom(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 16.0),
      padding:
          EdgeInsets.symmetric(horizontal: 8.0, vertical: addNew ? 16.0 : 0.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: addNew ? _buildForm(context) : _buildButton(context),
    );
  }
}
