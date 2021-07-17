import 'package:cafe_review/constant/colors.dart';
import 'package:cafe_review/features/cafe_detail/data/data.dart';
import 'package:flutter/material.dart';

class CafeListCard extends StatelessWidget {
  final CafeDetail detail;
  final double distance;
  final bool completed;
  final GestureTapCallback? onTap;

  const CafeListCard({
    Key? key,
    required this.detail,
    required this.distance,
    this.completed = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: AppColors.primary.withOpacity(0.34),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            detail.vicinity ?? 'Near by place.',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Distance: ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text('${distance.toStringAsFixed(2)} m'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rating: ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text('${detail.rating ?? 0.0}'),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color:
                          completed ? AppColors.primary : AppColors.shade[40],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
