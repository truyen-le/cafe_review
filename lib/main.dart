import 'package:cafe_review/constant/theme_light.dart';
import 'package:cafe_review/core/sl/injection.dart';
import 'package:flutter/material.dart';

import 'core/local/local_db.dart';
import 'features/cafe_detail/cafe_detail.dart';
import 'features/cafe_list/cafe_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDb().initLocalDb();
  LocalDb.registerAdapters();
  configureDependencies();
  configureCafeDetailDependencies();
  configureCafeListDependencies();
  runApp(CafeReviewApp());
}

class CafeReviewApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe Review',
      theme: themeLight,
      home: CafeListPage(),
    );
  }
}
