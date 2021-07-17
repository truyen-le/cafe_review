import 'package:cafe_review/constant/google_places_api.dart';
import 'package:cafe_review/core/network/dio_client.dart';
import 'package:cafe_review/core/sl/injection.dart';
import 'package:cafe_review/features/cafe_detail/cafe_detail.dart';

void configureCafeDetailDependencies() async {
  getIt.registerSingleton<CafeDetailApi>(
      CafeDetailApi(getIt.get<DioClient>(), DETAIL, API_KEY));
  getIt.registerSingleton<CafeDetailLocal>(CafeDetailLocal());
  getIt.registerSingleton(CafeDetailRepositories(
      getIt.get<CafeDetailApi>(), getIt.get<CafeDetailLocal>()));
  getIt.registerFactory<CafeDetailBloc>(
    () => CafeDetailBloc(getIt.get<CafeDetailRepositories>()),
  );
}
