import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/di/di.dart';
import 'core/helpers/shared_prefs_helper.dart';
import 'core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  AppRouter.init(true);
  setupLocator();

  /// initialize shared prefs
  await getIt<SharedPrefHelper>().init();
  runApp(MyApp());
}
