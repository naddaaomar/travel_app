import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/all_companies/models/AllCompanies.dart';
import 'package:p/screens/all_companies/data/data.dart';

part 'all_com_state.dart';

class AllComCubit extends Cubit<AllComState> {
  AllComCubit() : super(AllComInitial());
  static AllComCubit get(context) => BlocProvider.of(context);
  Data data = Data();

  getCom() async{
    try {
      emit(Loading());
      var response=await data.getAllCompanies();
      print(response);
      emit(Success(response));

    } catch (e) {
      print(e.toString());
      emit(Error());
    }
  }
}
