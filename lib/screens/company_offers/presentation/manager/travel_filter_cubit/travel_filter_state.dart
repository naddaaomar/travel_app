part of 'travel_filter_cubit.dart';

@immutable
sealed class TravelFilterState {}

final class TravelFilterInitial extends TravelFilterState {}
final class CloseAllDropDown extends TravelFilterState {}
final class ToggleCategory extends TravelFilterState {}
final class TogglePrice extends TravelFilterState {}
final class SelectCategory extends TravelFilterState {}
final class ClearCategory extends TravelFilterState {}
final class ChangePriceRange extends TravelFilterState {}
final class SelectPriceOrder extends TravelFilterState {}
final class ClearPrice extends TravelFilterState {}
