part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class NewestLoading extends HomeState {}
final class NewestSuccess extends HomeState {
  final NewestModel newestModel;

  NewestSuccess(this.newestModel);
}
final class NewestError extends HomeState {}
