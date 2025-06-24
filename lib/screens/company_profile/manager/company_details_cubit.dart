import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/company_profile/data/company_details.dart';
import 'package:p/screens/company_profile/models/CompanyDetails.dart';

part 'company_details_state.dart';

class CompanyDetailsCubit extends Cubit<CompanyDetailsState> {
  CompanyDetailsCubit() : super(CompanyDetailsInitial());

  CompanyDetailsData data = CompanyDetailsData();

  getCompanyDetails({required String id}) async {
    try {
      emit(CompanyDetailsLoading());
      CompanyDetailsModel companyDetailsModel =
          await data.getDetailsCompany(id: id);

      print(companyDetailsModel.address);
      emit(CompanyDetailsSuccess(companyDetailsModel));
    } catch (e) {
      print(e.toString());
      emit(CompanyDetailsError());
    }
  }
}
