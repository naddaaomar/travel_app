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
  final FavoritesCubit favoritesCubit;
  final TripsTabCubit tripsTabCubit;

  const MainProfileLoaded({
    required this.profileCubit,
    required this.favoritesCubit,
    required this.tripsTabCubit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainProfileLoaded &&
              runtimeType == other.runtimeType &&
              profileCubit == other.profileCubit &&
              favoritesCubit == other.favoritesCubit &&
              tripsTabCubit == other.tripsTabCubit;

  @override
  int get hashCode =>
      Object.hash(profileCubit, favoritesCubit, tripsTabCubit);
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