// import 'package:dio/dio.dart';
// import 'package:p/helpers/constants/constants.dart';
//
// import '../../company_profile/data/models/CompanyDetailsModel.dart';
//
// class CompanyDetailsData {
//   Dio dio = Dio();
//
//   getDetailsCompany({required String id}) async {
//     try {
//       var response = await dio.get("${Constants.baseURL}/api/Company/$id");
//       CompanyDetailsModel companyDetailsModel =
//           CompanyDetailsModel.fromJson(response.data);
//
//       print(companyDetailsModel.companyName);
//       print(companyDetailsModel.companyName);
//       print(companyDetailsModel.companyName);
//       return companyDetailsModel;
//     } on DioException catch (e) {
//       if (e.response == null) {
//         print("nulllllllllll");
//       }
//       print(e.error);
//     }
//   }
// }
