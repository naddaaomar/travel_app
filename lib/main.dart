import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:p/di.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/bloc_observer/bloc_observer.dart';
import 'package:p/helpers/themes/theme_data.dart';
import 'package:p/screens/auth/core/new_google_auth/g_auth_cubit.dart';
import 'package:p/screens/auth/core/new_google_auth/g_auth_repo.dart';
import 'package:p/screens/auth/core/new_google_auth/g_auth_state.dart';
import 'package:p/screens/home/views/home_view.dart';
import 'package:p/screens/settings/bloc/notification_bloc/notification_bloc.dart';
import 'package:p/screens/settings/bloc/permission_bloc/permissions_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'screens/settings/bloc/lang_bloc/lang_bloc.dart';
import 'screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'screens/splash_screen/view/splash.dart';
import 'screens/tabs/profile/profile_tabs/profile_tab_widgets/presentation/manager/profile_cubit.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
late GoogleAuthRepository googleAuthRepo;
late GoogleAuthCubit googleAuthCubit;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ApiManager.init();

  const secureStorage = FlutterSecureStorage();
  final token = await secureStorage.read(key: 'auth_token');

  final dio = Dio(BaseOptions(baseUrl: 'https://journeymate.runasp.net'));
  final googleSignIn = GoogleSignIn();

  googleAuthRepo = GoogleAuthRepository(
    dio: dio,
    googleSignIn: googleSignIn,
    storage: secureStorage,
  );

  googleAuthCubit = GoogleAuthCubit(googleAuthRepo);

  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  } catch (e) {
    Hive.init('hive_storage');
  }

  final prefs = await SharedPreferences.getInstance();
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
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => LocaleBloc()),
        BlocProvider(create: (context) => PermissionsBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(
          create: (context) => googleAuthCubit..checkAuthStatus(),
        ),
      ],
      child: MyApp(isFirstTime: isFirstTime),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

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
                navigatorObservers: [routeObserver],
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: MyThemeData.lightTheme,
                darkTheme: MyThemeData.darkTheme,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                home: BlocBuilder<GoogleAuthCubit, GoogleAuthState>(
                  builder: (context, authState) {
                    if (authState is GoogleAuthLoading) {
                      return const SplashScreen();
                    } else if (authState is GoogleAuthAuthenticated) {
                      return const HomeView();
                    } else {
                      return const SplashScreen();
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}