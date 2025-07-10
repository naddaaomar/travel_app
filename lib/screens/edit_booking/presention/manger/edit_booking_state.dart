part of 'edit_booking_cubit.dart';



@immutable
class EditBookingState {
  final bool isLoading;
  final bool isDeleteLoading;
  final bool isPutLoading;
  final bool isFocusedPeople;
  final bool isFocusedKids;
  final bool isFocusedFive;
  final bool isFocusedId;
  final bool isFocusedPhone;
  final bool isDone;
  final int? selectedChoice;
  final String? choiceStateTxt;
  final BookingModel? bookingModelEdit;
  final List<GetBookingModel>? getBookingModel;
  final double totalPrice;
  final int numAdults;
  final int numKidsAbove5;
  final int numKidsUnder5;
  final bool isFormValid;
  final String? error;
  final bool showProgress;
  final bool isEditDone;


  const EditBookingState({
    this.isLoading = false,
    this.isDeleteLoading = false,
    this.isPutLoading = false,
    this.isFocusedPeople = false,
    this.isFocusedKids = false,
    this.isFocusedFive = false,
    this.isFocusedId = false,
    this.isFocusedPhone = false,
    this.isDone = false,
    this.selectedChoice,
    this.choiceStateTxt,
    this.bookingModelEdit,
    this.getBookingModel,
    this.totalPrice = 0.0,
    this.numAdults = 0,
    this.numKidsAbove5 = 0,
    this.numKidsUnder5 = 0,
    this.isFormValid = false,
    this.error,
    this.showProgress = false,
    this.isEditDone = false,

  });

  EditBookingState copyWith({
    bool? isLoading,
    bool? isDeleteLoading,
    bool? isPutLoading,
    bool? isFocusedPeople,
    bool? isFocusedKids,
    bool? isFormValid,
    bool? isFocusedFive,
    bool? isFocusedId,
    bool? isFocusedPhone,
    bool? isDone,
    int? selectedChoice,
    String? choiceStateTxt,
    BookingModel? bookingModelEdit,
    List<GetBookingModel>? getBookingModel,
    double? totalPrice,
    int? numAdults,
    int? numKidsAbove5,
    int? numKidsUnder5,
    String? error,
    bool? showProgress,
    bool? isEditDone,

  }) {
    return EditBookingState(
      isLoading: isLoading ?? this.isLoading,
      isDeleteLoading: isDeleteLoading ?? this.isDeleteLoading,
      isPutLoading: isPutLoading ?? this.isPutLoading,
      isFocusedPeople: isFocusedPeople ?? this.isFocusedPeople,
      isFocusedKids: isFocusedKids ?? this.isFocusedKids,
      isFocusedFive: isFocusedFive ?? this.isFocusedFive,
      isFocusedId: isFocusedId ?? this.isFocusedId,
      isFocusedPhone: isFocusedPhone ?? this.isFocusedPhone,
      isDone: isDone ?? this.isDone,
      selectedChoice: selectedChoice ?? this.selectedChoice,
      choiceStateTxt: choiceStateTxt ?? this.choiceStateTxt,
      bookingModelEdit: bookingModelEdit ?? this.bookingModelEdit,
      getBookingModel: getBookingModel ?? this.getBookingModel,
      totalPrice: totalPrice ?? this.totalPrice,
      numAdults: numAdults ?? this.numAdults,
      numKidsAbove5: numKidsAbove5 ?? this.numKidsAbove5,
      numKidsUnder5: numKidsUnder5 ?? this.numKidsUnder5,
      isFormValid: isFormValid ?? this.isFormValid,
      error: error,
      showProgress: showProgress ?? this.showProgress,
      isEditDone: isEditDone ?? this.isEditDone,

    );
  }
}
