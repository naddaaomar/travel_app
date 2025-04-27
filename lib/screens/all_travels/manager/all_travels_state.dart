part of 'all_travels_cubit.dart';

@immutable
sealed class AllTravelsState {}

final class AllTravelsInitial extends AllTravelsState {}
final class AllTravelsSuccess extends AllTravelsState {
  AllTravelsModel allTravelsModel;

  AllTravelsSuccess(this.allTravelsModel);
}
final class AllTravelsLoading extends AllTravelsState {}
final class AllTravelsError extends AllTravelsState {}
