import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/domain/use_cases/booking_use_case.dart';
part 'booking_state.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  BookingCubit({required this.bookingUseCase}) : super(const BookingState()) {
    init();
  }

  static BookingCubit get(context) => BlocProvider.of(context);

  final BookingUseCase bookingUseCase;

  final focusNodePeople = FocusNode();
  final focusNodeKids = FocusNode();
  final focusNodeFive = FocusNode();
  final focusNodeId = FocusNode();
  final focusNodePhone = FocusNode();

  final numPeopleController = TextEditingController();
  final kidsController = TextEditingController();
  final fiveController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();

   bookingPost({
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final booking = await bookingUseCase.callPost(
        travelId: travelId,
        childrenUnderFiveNum: childrenUnderFiveNum,
        nationalId: nationalId,
        phoneNumber: phoneNumber,
        totalQuantity: totalQuantity,
      );

      booking.fold(
        (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
        (r) => emit(state.copyWith(isLoading: false, bookingModel: r)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

   bookingPut({
    required num travelId,
    required num totalQuantity,
    required num childrenUnderFiveNum,
    required String nationalId,
    required String phoneNumber,
    required int bookingId,
  }) async {
    emit(state.copyWith(isPutLoading: true, error: null));
    try {
      final booking = await bookingUseCase.callPut(
        bookingId: bookingId,
        travelId: travelId,
        totalQuantity: totalQuantity,
        phoneNumber: phoneNumber,
        nationalId: nationalId,
        childrenUnderFiveNum: childrenUnderFiveNum,
      );

      booking.fold(
        (l) => emit(state.copyWith(isPutLoading: false, error: l.toString())),
        (r) => emit(state.copyWith(isPutLoading: false, bookingModel: r)),
      );
    } catch (e) {
      emit(state.copyWith(isPutLoading: false, error: e.toString()));
    }
  }

  bookingDelete({required int bookingId}) async {
    emit(state.copyWith(isDeleteLoading: true, error: null));
    try {
      await bookingUseCase.callDelete(bookingId: bookingId);
      emit(state.copyWith(isDeleteLoading: false));
      getBooking();
    } catch (e) {
      emit(state.copyWith(isDeleteLoading: false, error: e.toString()));
    }
  }

   getBooking() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final booking = await bookingUseCase.callGet();
      booking.fold(
        (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
        (r) => emit(state.copyWith(isLoading: false, getBookingModel: r)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void doneBooking({required bool currentValue}) {
    emit(state.copyWith(isDone: !currentValue));
  }

  void calculateTotalPrice({
    required num pricePerPerson,
  }) {
    final adults = int.tryParse(numPeopleController.text.trim()) ?? 0;
    final kidsAbove5 = int.tryParse(kidsController.text.trim()) ?? 0;
    final kidsUnder5 = int.tryParse(fiveController.text.trim()) ?? 0;

    final total = (adults * pricePerPerson) +
        (kidsAbove5 * pricePerPerson) +
        (kidsUnder5 * (pricePerPerson * 0.5));

    emit(state.copyWith(
      totalPrice: total,
      numAdults: adults,
      numKidsAbove5: kidsAbove5,
      numKidsUnder5: kidsUnder5,
    ));
  }
  void updateFormValidity(bool isValid) {
    emit(state.copyWith(isFormValid: isValid));
  }
  void showProgressThenPay() async {
    emit(state.copyWith(showProgress: true));


    await Future.delayed(Duration(milliseconds: 1500));

    emit(state.copyWith(showProgress: false, isFormValid: true));
  }

  String getSummaryText() {
    final parts = <String>[];

    if (state.numAdults > 0) {
      parts.add('${state.numAdults} adult${state.numAdults > 1 ? 's' : ''}');
    }

    if (state.numKidsAbove5 > 0) {
      parts.add(
          '${state.numKidsAbove5} kid${state.numKidsAbove5 > 1 ? 's' : ''} above 5');
    }

    if (state.numKidsUnder5 > 0) {
      parts.add(
          '${state.numKidsUnder5} kid${state.numKidsUnder5 > 1 ? 's' : ''} under 5');
    }

    return parts.isEmpty ? '' : 'Total: ${parts.join(', ')}';
  }

  void choiceState() {
    if (state.selectedChoice == null) {
      emit(state.copyWith(choiceStateTxt: 'Make a choice'));
    }
  }

  void selectedKids({required int? num}) {
    emit(state.copyWith(selectedChoice: num));
  }

  void init() {
    focusNodePeople.addListener(() {
      emit(state.copyWith(isFocusedPeople: focusNodePeople.hasFocus));
    });

    focusNodeKids.addListener(() {
      emit(state.copyWith(isFocusedKids: focusNodeKids.hasFocus));
    });

    focusNodeFive.addListener(() {
      emit(state.copyWith(isFocusedFive: focusNodeFive.hasFocus));
    });

    numPeopleController.addListener(() => emit(state));
    kidsController.addListener(() => emit(state));
    fiveController.addListener(() => emit(state));
  }

  @override
  Future<void> close() {
    focusNodePeople.dispose();
    focusNodeKids.dispose();
    focusNodeFive.dispose();
    numPeopleController.dispose();
    kidsController.dispose();
    fiveController.dispose();
    return super.close();
  }
}
