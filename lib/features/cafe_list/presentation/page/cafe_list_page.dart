import 'package:cafe_review/constant/colors.dart';
import 'package:cafe_review/core/sl/injection.dart';
import 'package:cafe_review/core/util/location.dart';
import 'package:cafe_review/features/cafe_list/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CafeListPage extends StatefulWidget {
  const CafeListPage({Key? key}) : super(key: key);

  @override
  _CafeListPageState createState() => _CafeListPageState();
}

class _CafeListPageState extends State<CafeListPage> {
  late Future<Position> _position;

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

  Widget _buildBody(BuildContext context, Position position) {
    return BlocBuilder<CafeListBloc, CafeListState>(
      builder: (context, state) {
        if (state is CafeListEmpty) {
          context.read<CafeListBloc>().add(
              CafeListRequestNewList(position.latitude, position.longitude));
        }
        if (state is CafeListLoading) {
          return _buildLoading(context, 'Getting nearby Cafe shop...');
        }
        if (state is CafeListLoadingFinished) {
          return Container(
            child: ListView.builder(
              itemCount: state.cafeList.length,
              itemBuilder: (_, index) {
                final detail = state.cafeList[index];
                final distance = Geolocator.distanceBetween(
                    position.latitude,
                    position.longitude,
                    detail.geometry.location.latitude,
                    detail.geometry.location.longitude);
                return CafeListCard(
                  detail: detail,
                  distance: distance,
                  onTap: () {},
                );
              },
            ),
          );
        }
        return Container(
          child: Center(
            child: Text(
                'Latitude: ${position.latitude}, Longitude: ${position.longitude}'),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _position = getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CafeListBloc>(
      create: (_) => getIt.get<CafeListBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cafe Review',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AppColors.background,
                  fontSize: 22.0,
                ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<Position>(
          future: _position,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text(
                      'An error has occur while getting your location. Please try again later.'),
                ),
              );
            }
            if (snapshot.hasData) {
              return _buildBody(context, snapshot.data!);
            }
            return _buildLoading(context, 'Getting your location...');
          },
        ),
      ),
    );
  }
}
