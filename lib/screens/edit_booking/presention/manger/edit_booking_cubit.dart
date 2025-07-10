import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';

part 'edit_booking_state.dart';

class EditBookingCubit extends Cubit<EditBookingState> {
  EditBookingCubit() : super(EditBookingState()){init();}

  static EditBookingCubit get(context) => BlocProvider.of(context);



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




  isEditDone(){
    emit(state.copyWith(isEditDone: true));
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
  Future<void> putBooking({
    required BookingCubit bookingCubit,
    required GetBookingModel model,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final booking = await bookingCubit.bookingPut(
        bookingId: model.id!.toInt(),
        travelId: model.bookingItem?.travelId ?? 0,
        nationalId: idController.text,
        totalQuantity: int.tryParse(numPeopleController.text.trim()) ?? 0,
        phoneNumber: phoneController.text,
        childrenUnderFiveNum: int.tryParse(kidsController.text.trim()) ?? 0,
      );

      emit(state.copyWith(
        bookingModelEdit: booking,
        isLoading: false,
        isEditDone: true,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
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
