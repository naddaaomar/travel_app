import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/all_travels/domain/use_cases/all_travels_use_case.dart';
import '../../data/models/AllTravelsModel.dart';

part 'all_travels_state.dart';

@injectable
class AllTravelsCubit extends Cubit<AllTravelsState> {
  AllTravelsCubit(this.allTravelsUseCase) : super(const AllTravelsState());

  final AllTravelsUseCase allTravelsUseCase;
  static AllTravelsCubit get(context) => BlocProvider.of(context);

  final ScrollController scrollController = ScrollController();
  int currentPage = 1;

  void scrollToCurrentPage() {
    double buttonWidth = 20;
    double scrollOffset = (currentPage - 1) * (buttonWidth + 10);

    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(scrolledToPage: true));
  }

  Future<void> getAllTravels({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId

  }) async {
    try {
      emit(state.copyWith(isLoading: true, hasError: false));
      final response = await allTravelsUseCase.call(
        PageIndex: PageIndex,
        PageSize: PageSize,
        Sort: Sort,
        MaxPrice: MaxPrice,
        MinPrice: MinPrice,
        CategorieyId: CategorieyId
      );

      currentPage = PageIndex;

      response.fold(
            (l) {
          print(l.toString());
          emit(state.copyWith(isLoading: false, hasError: true));
        },
            (r) {
          emit(state.copyWith(
            isLoading: false,
            hasError: false,
            allTravelsModel: r,
          ));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
