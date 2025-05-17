part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}
final class ChangeKidsSelected extends BookingState {}
final class InitListenerPeople extends BookingState {}
final class InitListenerKids extends BookingState {}
final class InitListenerFive extends BookingState {}
final class PeopleControllerListener extends BookingState {}
final class KidsControllerListener extends BookingState {}
final class FiveControllerListener extends BookingState {}
final class DoneBooking extends BookingState {}
final class ChoiceState extends BookingState {}
final class PriceCalculated extends BookingState {}
final class BookingLoading extends BookingState {}
final class BookingSuccess extends BookingState {
  BookingModel bookingModel;

  BookingSuccess({required this.bookingModel});
}
final class BookingError extends BookingState {}
