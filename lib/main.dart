import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/di.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/bloc_observer/bloc_observer.dart';
import 'package:p/helpers/themes/theme_data.dart';
import 'package:p/screens/settings/lang_bloc/lang_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home/views/home_view.dart';
import 'screens/onboard/views/onboard_view.dart';
import 'screens/settings/theme_bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ApiManager.init();
  Bloc.observer = MyBlocObserver();
  configureDependencies();

  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: Locale("en"),
      saveLocale: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(create: (context) => LocaleBloc()),
        ],
        child: MyApp(),
      )));
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeBloc, ThemeMode>(
          builder: (context, themeMode) {
            return ScreenUtilInit(
              designSize: const Size(420, 880),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) => MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: locale, // Locale is now dynamically provided by the Bloc
                theme: MyThemeData.lightTheme,
                darkTheme: MyThemeData.darkTheme,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                home: OnBoardView(),
              ),
            );
          },
        );
      },
    );
  }
}
