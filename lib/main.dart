import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:p/di.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/helpers/bloc_observer/bloc_observer.dart';
import 'package:p/helpers/themes/theme_data.dart';
import 'package:p/screens/settings/bloc/notification_bloc/notification_bloc.dart';
import 'package:p/screens/settings/bloc/permission_bloc/permissions_bloc.dart';
import 'package:p/screens/user_interaction/data/data_sources/local/hive_interaction_local_ds.dart';
import 'package:p/screens/user_interaction/data/data_sources/remote/interaction_remote_ds.dart';
import 'package:p/screens/user_interaction/data/models/event_interaction_model.dart';
import 'package:p/screens/user_interaction/data/repositories/interaction_repository_impl.dart';
import 'package:p/screens/user_interaction/domain/use_cases/send_interactions.dart';
import 'package:p/screens/user_interaction/presentation/manager/interaction_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/onboard/views/widgets/onboard_view_body.dart';
import 'screens/settings/bloc/lang_bloc/lang_bloc.dart';
import 'screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'screens/splash_screen/view/splash.dart';
import 'screens/tabs/profile/profile_tabs/profile_tab_widgets/presentation/manager/profile_cubit.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
late String? token;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ApiManager.init();
  await AndroidAlarmManager.initialize();

  final prefs = await SharedPreferences.getInstance();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter(EventInteractionModelAdapter());
  await Hive.openBox<EventInteractionModel>('interactions');

  token = prefs.getString('token');

  if (kIsWeb) {
    print("Running on Web");
  } else {
    print("Running on Mobile");
  }

  if (token == null || token!.isEmpty) {
    print("Token not loaded from cache (Platform: ${kIsWeb ? 'Web' : 'Mobile'})");
  } else {
    print("Token loaded from cache: $token");
  }

  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  } catch (e) {
    Hive.init('hive_storage');
  }

  await AndroidAlarmManager.periodic(
    const Duration(days: 7),
    123,
    sendUserInteractionCallback,
    wakeup: true,
    exact: true,
    rescheduleOnReboot: true,
  );


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
        BlocProvider(create: (context) => getIt<InteractionCubit>()),
      ],
      child: MyApp(isFirstTime: isFirstTime),
    ),
  ));
}
@pragma('vm:entry-point')
Future<void> sendUserInteractionCallback() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies needed for clean arch
  ApiManager.init();

  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('user_id');
  if (userId == null) return;

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.initFlutter();

  // Register adapter
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(EventInteractionModelAdapter());
  }

  // Open Hive box
  final box = await Hive.openBox<EventInteractionModel>('interactions');

  // Create data sources and repository
  final local = HiveInteractionLocalDataSourceImpl(box);
  final remote = InteractionRemoteDataSource(ApiManager());
  final repo = InteractionRepositoryImpl(local, remote);

  // Use case
  final useCase = SendInteractionsUseCase(repo);

  try {
    print("🧠 Background Task Running to Send Interactions");
    print("🔍 Found interactions: ${box.values.length}");

    await useCase.call(userId);
    print("✅ Sent user interactions successfully");
  } catch (e) {
    print("🚨 Error sending interactions: $e");
  }
}



final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool isFirstTime;


  MyApp({super.key,required this.isFirstTime, });
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
                  scaffoldMessengerKey: scaffoldMessengerKey,
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
                    home:
                     isFirstTime ?
                    SplashScreen()
                   : OnBoardViewBody(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

void showNoInternetSnackBar() {
  Future.microtask(() {
    scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
      content: Text(
      'Connect to the internet',
      style: TextStyle(fontSize: 12, fontFamily: "pop"),
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    elevation: 7,
    backgroundColor: Color(0xff242931).withOpacity(.7),
    margin:
    EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    ),
    );
  });
}
