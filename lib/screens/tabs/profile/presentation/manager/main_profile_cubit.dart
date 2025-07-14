import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../profile_tabs/favorite_tabs/presentiton/manager/combined_favorites_cubit.dart';
import '../../profile_tabs/profile_tab_widgets/presentation/manager/profile_cubit.dart';
import '../../profile_tabs/profile_tab_widgets/presentation/manager/profile_state.dart';
import '../../profile_tabs/trips_tab_widgets/presentation/manager/tripstab_cubit.dart';

part 'main_profile_state.dart';

class MainProfileCubit extends Cubit<MainProfileState> {
  final http.Client client;
  late final ProfileCubit _profileCubit;
  late final CombinedFavoritesCubit _combinedFavoritesCubit;
  late final TripsTabCubit _tripsTabCubit;

  MainProfileCubit({required this.client}) : super(MainProfileInitial()) {
    _initializeCubits();
  }

  Future<void> _initializeCubits() async {
    emit(MainProfileLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('name') ?? '';
      final email = prefs.getString('email') ?? '';
      final password = prefs.getString('password') ?? '';

      _profileCubit = ProfileCubit()..loadProfile(name, email, password);
      _combinedFavoritesCubit = CombinedFavoritesCubit(client: client);
      _tripsTabCubit = TripsTabCubit(client: client)..fetchTrips();

      emit(MainProfileLoaded(
        profileCubit: _profileCubit,
        combinedFavoritesCubit: _combinedFavoritesCubit,
        tripsTabCubit: _tripsTabCubit,
      ));
    } catch (e) {
      emit(MainProfileError('Failed to initialize profile: ${e.toString()}'));
    }
  }

  Future<void> refreshAllData() async {
    try {
      emit(MainProfileRefreshing());
      await _profileCubit.loadProfile(
        _profileCubit.state is ProfileLoaded
            ? (_profileCubit.state as ProfileLoaded).profile.name
            : '',
        _profileCubit.state is ProfileLoaded
            ? (_profileCubit.state as ProfileLoaded).profile.email
            : '',
        _profileCubit.state is ProfileLoaded
            ? (_profileCubit.state as ProfileLoaded).profile.password
            : '',
      );
      await _combinedFavoritesCubit.fetchAll();
      await _tripsTabCubit.fetchTrips();
      emit(MainProfileLoaded(
        profileCubit: _profileCubit,
        combinedFavoritesCubit: _combinedFavoritesCubit,
        tripsTabCubit: _tripsTabCubit,
      ));
    } catch (e) {
      emit(MainProfileError('Failed to refresh data: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _profileCubit.close();
    _combinedFavoritesCubit.close();
    _tripsTabCubit.close();
    return super.close();
  }
}