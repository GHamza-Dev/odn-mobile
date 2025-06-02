import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:switch_config/core/storage/token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:switch_config/features/scan_boitier/presentation/pages/passeport_produit.dart';

import 'core/bindings/initial_binding.dart';
import 'core/controllers/loading_controller.dart';
import 'core/router/app_routes.dart';
import 'core/themes/app_theme.dart';

import 'features/auth/presentation/bindings/auth_binding.dart';
import 'features/auth/presentation/pages/login_page.dart';

import 'features/create_itinerary/presentation/bindings/create_itinerary_binding.dart';
import 'features/create_itinerary/presentation/pages/create_itinerary_page.dart';
import 'features/home/presentation/bindings/home_binding.dart';
import 'features/home/presentation/pages/home_page.dart';

import 'features/scan_boitier/presentation/bindings/scan_boitier_binding.dart';
import 'features/scan_boitier/presentation/pages/stepper_scan_boitier_page.dart';

import 'features/tasks_map/presentation/bindings/tasks_map_binding.dart';
import 'features/tasks_map/presentation/pages/tasks_map_page.dart';
import 'shared/widgets/colored_safearea.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final token = await SecureTokenStorage.read();
  final initialRoute = (token != null) ? Routes.home : Routes.login;

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('fr'), Locale('en')],
      fallbackLocale: const Locale('fr'),
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      child: GetMaterialApp(
        title: 'ODN Digitalisation',
        debugShowCheckedModeBanner: false,

        locale: context.locale,

        supportedLocales: context.supportedLocales,

        localizationsDelegates: context.localizationDelegates,

        fallbackLocale: const Locale('fr'),


        initialRoute: initialRoute,
        initialBinding: InitialBinding(),

        getPages: [
          GetPage(
            name: Routes.login,
            page: () => LoginPage(),
            binding: AuthBinding(),
          ),
          GetPage(
            name: Routes.home,
            page: () => const HomePage(),
            binding: HomeBinding(),
          ),
          GetPage(
            name: Routes.scanBoitier,
            page: () => const StepperScanBoitierPage(),
            binding: ScanBoitierBinding(),
          ),
          GetPage(
            name: Routes.recap,
            page: () => const PasseportProduit(),
            binding: ScanBoitierBinding(),
          ),
          GetPage(
            name: Routes.tasksMap,
            page: ()    => TasksMapPage(),
            binding:    TasksMapBinding(),
          ),
          GetPage(
            name: Routes.createItinerary,
            page: ()    => const CreateItineraryPage(),
            binding:    CreateItineraryBinding(),
          ),
        ],
        theme: AppTheme.fromLocale(context.locale),

        builder: (context, child) {
          return Stack(
            children: [
              if (child != null) child,
              GetX<LoadingController>(
                builder: (lc) {
                  if (!lc.isLoading) return const SizedBox.shrink();
                  return Container(
                    color: Colors.black45,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}