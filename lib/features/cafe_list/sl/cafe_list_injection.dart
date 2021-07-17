import 'package:cafe_review/constant/google_places_api.dart';
import 'package:cafe_review/core/network/dio_client.dart';
import 'package:cafe_review/core/sl/injection.dart';
import 'package:cafe_review/features/cafe_list/cafe_list.dart';

void configureCafeListDependencies() async {
  getIt.registerSingleton<CafeListApi>(
      CafeListApi(getIt.get<DioClient>(), NEAR_BY, API_KEY));
  getIt.registerSingleton<CafeListLocal>(CafeListLocal());
  getIt.registerSingleton(CafeListRepositories(
      getIt.get<CafeListApi>(), getIt.get<CafeListLocal>()));
  getIt.registerFactory<CafeListBloc>(
    () => CafeListBloc(getIt.get<CafeListRepositories>()),
  );
}
