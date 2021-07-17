import 'package:cafe_review/constant/colors.dart';
import 'package:cafe_review/core/sl/injection.dart';
import 'package:cafe_review/features/cafe_detail/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CafeDetailPage extends StatelessWidget {
  final String placeId;

  const CafeDetailPage(this.placeId, {Key? key}) : super(key: key);

  static Route route(String placeId) {
    return MaterialPageRoute<void>(builder: (_) => CafeDetailPage(placeId));
  }

  Widget _buildLoading(BuildContext context, String message) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
            Text(message),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: AppColors.error,
              size: 24,
            ),
            Text(message),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CafeDetailBloc, CafeDetailState>(
      builder: (context, state) {
        if (state is CafeDetailEmpty) {
          context.read<CafeDetailBloc>().add(CafeDetailRequest(placeId));
        }
        if (state is CafeDetailLoading) {
          return _buildLoading(context, 'Getting place info.');
        }
        if (state is CafeDetailLoadingError) {
          return _buildError(
              context, 'Unable to get place info. Please try again later.');
        }

        if (state is CafeDetailLoadingFinished) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CafeDetailCard(detail: state.detail),
                  AddNewReview(),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CafeDetailBloc>(
      create: (_) => getIt.get<CafeDetailBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).backgroundColor,
          ),
          title: Text(
            'Cafe Review',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AppColors.background,
                  fontSize: 22.0,
                ),
          ),
          centerTitle: true,
        ),
        body: _buildBody(context),
      ),
    );
  }
}
