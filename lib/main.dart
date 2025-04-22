import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/di.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/bloc_observer/bloc_observer.dart';
import 'package:p/helpers/themes/theme_data.dart';
import 'package:p/screens/onboard/views/widgets/onboard_view_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/settings/bloc/lang_bloc/lang_bloc.dart';
import 'screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'screens/splash_screen/view/splash.dart';
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ApiManager.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isFirstTime = prefs.getBool('onboarding_seen') ?? false;
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
        child: MyApp(isFirstTime: isFirstTime),
      )));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  MyApp({super.key,required this.isFirstTime});
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
              builder: (context, child) => BlocListener<LocaleBloc, Locale>(
                listener: (context, locale) async {
                  await EasyLocalization.of(context)!.setLocale(locale);
                },
                child: MaterialApp(
                  navigatorObservers: [routeObserver],
                  navigatorKey: navigatorKey,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale:
                  context.locale,
                  theme: MyThemeData.lightTheme,
                  darkTheme: MyThemeData.darkTheme,
                  themeMode: themeMode,
                  debugShowCheckedModeBanner: false,
                  home: isFirstTime ? SplashScreen() : OnBoardViewBody(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
