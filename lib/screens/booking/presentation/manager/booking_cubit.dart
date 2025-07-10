import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/domain/use_cases/booking_use_case.dart';

part 'booking_state.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  BookingCubit({required this.bookingUseCase}) : super(BookingInitial()) {
    init();
  }
  static BookingCubit get(context) => BlocProvider.of(context);
  int? selectedChoice;
  String? choiceStateTxt;

  final focusNodePeople = FocusNode();
  final focusNodeKids = FocusNode();
  final focusNodeFive = FocusNode();

  bool isFocusedPeople = false;
  bool isFocusedFive = false;
  bool isFocusedKids = false;
  TextEditingController numPeopleController = TextEditingController();
  TextEditingController kidsController = TextEditingController();
  TextEditingController fiveController = TextEditingController();
  int numAdults = 0;
  int numKidsAbove5 = 0;
  int numKidsUnder5 = 0;
  double totalPrice = 0.0;

  bool isDone = false;

  BookingUseCase bookingUseCase;

  bookingPut({
    required num travelId,
    required num quantity,
    required int bookingId
  }) async{
    try {
      emit(BookingPutLoading());
      var booking = await bookingUseCase.callPut(
          bookingId: bookingId,
          travelId: travelId,
          quantity: quantity);
      booking.fold(
            (l) {
          emit(BookingPutError());
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
        },
            (r) {
          emit(BookingPutSuccess(bookingModel: r));
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
        },
      );
    } catch (e) {
      print(e);
    }
  }
  bookingDelete({required int bookingId}) async {
    try {
      emit(BookingDeleteLoading());
      await bookingUseCase.callDelete(bookingId: bookingId);
      emit(BookingDeleteSuccess());
    } catch (e) {
      emit(BookingDeleteError());
      print(e.toString());
    }
  }

  bookingCall({
    required num travelId,
    required num quantity,
  }) async {
    try {
      emit(BookingLoading());
      var booking = await bookingUseCase.call(
        //  buyerEmail: buyerEmail,
          travelId: travelId,
          quantity: quantity);
      booking.fold(
            (l) {
          emit(BookingError());
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
          print(l);
        },
            (r) {
          emit(BookingSuccess(bookingModel: r));
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
          print(r.buyerEmail);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  doneBooking({required bool currentValue}) {
    isDone = !currentValue;
    emit(DoneBooking());
  }

  void calculateTotalPrice({
    required num pricePerPerson,
    required TextEditingController numPeopleController,
    required TextEditingController kidsController,
    required TextEditingController fiveController,
  }) {
    final adults = int.tryParse(numPeopleController.text.trim()) ?? 0;
    final kidsAbove5 = int.tryParse(kidsController.text.trim()) ?? 0;
    final kidsUnder5 = int.tryParse(fiveController.text.trim()) ?? 0;

    numAdults = adults;
    numKidsAbove5 = kidsAbove5;
    numKidsUnder5 = kidsUnder5;

    totalPrice = (numAdults * pricePerPerson) +
        (numKidsAbove5 * pricePerPerson) +
        (numKidsUnder5 * (pricePerPerson * 0.5));

    emit(PriceCalculated());
  }

  String getSummaryText() {
    List<String> parts = [];

    if (numAdults > 0) parts.add('$numAdults adult${numAdults > 1 ? 's' : ''}');
    if (numKidsAbove5 > 0)
      parts.add('$numKidsAbove5 kid${numKidsAbove5 > 1 ? 's' : ''} above 5');
    if (numKidsUnder5 > 0)
      parts.add('$numKidsUnder5 kid${numKidsUnder5 > 1 ? 's' : ''} under 5');

    return parts.isEmpty ? '' : 'Total: ${parts.join(', ')}';
  }

  choiceState() {
    if (selectedChoice == null) {
      choiceStateTxt = "Make a choice";
      emit(ChoiceState());
    }
  }

  void init() {
    focusNodePeople.addListener(() {
      isFocusedPeople = focusNodePeople.hasFocus;
      emit(InitListenerPeople());
    });

    focusNodeKids.addListener(() {
      isFocusedKids = focusNodeKids.hasFocus;
      emit(InitListenerKids());
    });
    focusNodeFive.addListener(() {
      isFocusedKids = focusNodeFive.hasFocus;
      emit(InitListenerFive());
    });
    numPeopleController.addListener(() {});
    emit(PeopleControllerListener());

    kidsController.addListener(() {});
    emit(KidsControllerListener());

    fiveController.addListener(() {});
    emit(FiveControllerListener());
  }

  selectedKids({required int? num}) {
    selectedChoice = num;
    emit(ChangeKidsSelected());
  }

  @override
  Future<void> close() {
    focusNodePeople.dispose();
    focusNodeKids.dispose();
    kidsController.dispose();
    numPeopleController.dispose();
    return super.close();
  }

// void onFocusChanged(bool focus) {
//   isFocusedPeople = focus;
//   emit(focus ? BookingInputFocused() : BookingInputUnfocused());
// }

// void onInputChanged(String value) {
//   input = value;
//   emit(BookingInputChanged());
//
//   if (value.trim().isNotEmpty) {
//     emit(BookingInputValid());
//   } else {
//     emit(BookingInputInvalid());
//   }
// }
}