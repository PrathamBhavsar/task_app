import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/di/di.dart';
import 'core/helpers/cache_helper.dart';
import 'core/helpers/shared_prefs_helper.dart';
import 'core/router/app_router.dart';
import 'domain/entities/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setupLocator();

  /// initialize shared prefs
  await getIt<SharedPrefHelper>().init();

  final cacheManager = getIt<CacheHelper>();
  final User? user = await cacheManager.getInitUser();

  AppRouter.init(user != null);
  runApp(MyApp());
}
