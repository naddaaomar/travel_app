import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/tabs/home/data/models/EventsModel.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'package:p/screens/tabs/home/domain/use_cases/home_use_case.dart';

part 'home_state.dart';
@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeUseCase) : super(const HomeState());

  final HomeUseCase homeUseCase;
  int currentPage = 1;

  static HomeCubit get(context) => BlocProvider.of(context);

  call({
    required int PageIndex,
    required int PageSize,
  })async{
   await getNewest(PageIndex: PageIndex, PageSize: PageSize);
   await getEvents();
  }
  Future<void> getNewest({
    required int PageIndex,
    required int PageSize,
  }) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final response = await homeUseCase.call(PageIndex: PageIndex, PageSize: PageSize);
      currentPage = PageIndex;

      response.fold(
            (failure) => emit(state.copyWith(isLoading: false, hasError: true)),
            (data) => emit(state.copyWith(
          isLoading: false,
          hasError: false,
          newestModel: data,
        )),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  Future<void> getEvents() async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final response = await homeUseCase.callEvents();

      response.fold(
            (failure) => emit(state.copyWith(isLoading: false, hasError: true)),
            (data) => emit(state.copyWith(
          isLoading: false,
          hasError: false,
          eventsModel: data,
        )),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
