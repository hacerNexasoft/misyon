import 'package:common/common.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/config/theme/themes.dart';
import 'package:misyonbank/product/localization/localization_service.dart';
import 'package:misyonbank/product/localization/localizations_delegate.dart';
import 'package:misyonbank/product/services/cache_box_service.dart';
import 'package:misyonbank/product/services/getx_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await CacheBoxService.initBoxes();
  await GetxManager.setupServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          getPages: AppViews.routes,
          initialRoute: AppViews.initial,
          theme: lightTheme,
          darkTheme: lightTheme,
          translations: AppLanguages(),
          locale: Get.find<LocalizationService>().getLocale(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
