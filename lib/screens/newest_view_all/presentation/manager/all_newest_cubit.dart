import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/newest_view_all/data/remote/models/AllNewestModel.dart';
import 'package:p/screens/newest_view_all/domain/use_cases/all_newest_use_case.dart';

part 'all_newest_state.dart';

@injectable
class AllNewestCubit extends Cubit<AllNewestState> {
  AllNewestCubit(this.allNewestUseCase) : super(const AllNewestState());

  final AllNewestUseCase allNewestUseCase;
  static AllNewestCubit get(context) => BlocProvider.of(context);

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

  Future<void> getAllNewest({
    required int PageIndex,
    required int PageSize,
    String? Sort,
    double?MinPrice,
    double?MaxPrice,
    int? CategorieyId

  }) async {
    try {
      emit(state.copyWith(isLoading: true, hasError: false));
      final response = await allNewestUseCase.call(
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