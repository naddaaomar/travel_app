part of 'main_profile_cubit.dart';

sealed class MainProfileState {
  const MainProfileState();
}

class MainProfileInitial extends MainProfileState {
  const MainProfileInitial();
}

class MainProfileLoading extends MainProfileState {
  const MainProfileLoading();
}

class MainProfileRefreshing extends MainProfileState {
  const MainProfileRefreshing();
}

class MainProfileLoaded extends MainProfileState {
  final ProfileCubit profileCubit;
  final CombinedFavoritesCubit combinedFavoritesCubit;
  final TripsTabCubit tripsTabCubit;

  const MainProfileLoaded({
    required this.profileCubit,
    required this.combinedFavoritesCubit,
    required this.tripsTabCubit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainProfileLoaded &&
              runtimeType == other.runtimeType &&
              profileCubit == other.profileCubit &&
              combinedFavoritesCubit == other.combinedFavoritesCubit &&
              tripsTabCubit == other.tripsTabCubit;

  @override
  int get hashCode =>
      Object.hash(profileCubit, combinedFavoritesCubit, tripsTabCubit);
}

class MainProfileError extends MainProfileState {
  final String message;

  const MainProfileError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainProfileError &&
              runtimeType == other.runtimeType &&
              message == other.message;

  @override
  int get hashCode => message.hashCode;
}