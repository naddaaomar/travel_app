import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/tabs/home/data/models/NewestModel.dart';
import 'package:p/screens/tabs/home/domain/use_cases/home_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeUseCase) : super(HomeInitial());
  HomeUseCase homeUseCase;
  int currentPage = 1;

  static HomeCubit get(context) => BlocProvider.of(context);

  getNewest({
    required int PageIndex,
    required int PageSize,
  }) async {
    try {
      emit(NewestLoading());
      var response =
          await homeUseCase.call(PageIndex: PageIndex, PageSize: PageSize);
      print(response);
      currentPage = PageIndex;

      response.fold(
        (l) {
          emit(NewestError());
          print(l.toString());
        },
        (r) {
          emit(NewestSuccess(r));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(NewestError());
    }
  }
}
