// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import 'helpers/api_manager/api_manager.dart' as _i501;
import 'helpers/internet_checker/injection_module.dart' as _i1017;
import 'helpers/internet_checker/internet_checker.dart' as _i483;
import 'helpers/internet_checker/internet_checker_impl.dart' as _i347;
import 'screens/all_companies/data/data_sources/local/all_companies_local_ds.dart'
    as _i631;
import 'screens/all_companies/data/data_sources/local/all_companies_local_ds_impl.dart'
    as _i496;
import 'screens/all_companies/data/data_sources/remote/all_companies_ds.dart'
    as _i69;
import 'screens/all_companies/data/data_sources/remote/all_companies_ds_impl.dart'
    as _i200;
import 'screens/all_companies/data/repositories/all_companies_repo_impl.dart'
    as _i297;
import 'screens/all_companies/domain/repositories/all_companies_repo.dart'
    as _i847;
import 'screens/all_companies/domain/use_cases/all_companies_use_case.dart'
    as _i903;
import 'screens/all_companies/presentation/manager/all_com_cubit.dart' as _i40;
import 'screens/all_discount_travels/data/local/data_sources/all_discounts_local_ds.dart'
    as _i219;
import 'screens/all_discount_travels/data/local/data_sources/all_discounts_local_ds_impl.dart'
    as _i793;
import 'screens/all_discount_travels/data/remote/data_sources/all_discounts_ds.dart'
    as _i529;
import 'screens/all_discount_travels/data/remote/data_sources/all_discounts_ds_impl.dart'
    as _i154;
import 'screens/all_discount_travels/data/repositories/all_discounts_repo_impl.dart'
    as _i438;
import 'screens/all_discount_travels/domain/repositories/all_discounts_repo.dart'
    as _i591;
import 'screens/all_discount_travels/domain/use_cases/all_discunts_use_case.dart'
    as _i750;
import 'screens/all_discount_travels/presentation/manager/all_discounts_cubit.dart'
    as _i230;
import 'screens/all_travels/data/data_sources/local/all_travels_local_ds.dart'
    as _i419;
import 'screens/all_travels/data/data_sources/local/all_travels_local_ds_impl.dart'
    as _i592;
import 'screens/all_travels/data/data_sources/remote/all_travels_ds.dart'
    as _i842;
import 'screens/all_travels/data/data_sources/remote/all_travels_ds_impl.dart'
    as _i665;
import 'screens/all_travels/data/repositories/all_travels_repo_impl.dart'
    as _i509;
import 'screens/all_travels/domain/repositories/all_travels_repo.dart' as _i795;
import 'screens/all_travels/domain/use_cases/all_travels_use_case.dart'
    as _i880;
import 'screens/all_travels/presentation/manager/all_travels_cubit.dart'
    as _i44;
import 'screens/booking/data/data_sources/remote/booking_ds.dart' as _i61;
import 'screens/booking/data/data_sources/remote/booking_ds_impl.dart' as _i708;
import 'screens/booking/data/repositories/booking_repo_impl.dart' as _i659;
import 'screens/booking/domain/repositories/booking_repo.dart' as _i991;
import 'screens/booking/domain/use_cases/booking_use_case.dart' as _i617;
import 'screens/booking/presentation/manager/booking_cubit.dart' as _i344;
import 'screens/company_offers/data/data_sources/remote/company_discounts_ds.dart'
    as _i905;
import 'screens/company_offers/data/data_sources/remote/company_discounts_ds_impl.dart'
    as _i536;
import 'screens/company_offers/data/repositories/company_discounts_repo_impl.dart'
    as _i351;
import 'screens/company_offers/domain/repositories/company_discounts_repo.dart'
    as _i814;
import 'screens/company_offers/domain/use_cases/company_discounts_use_case.dart'
    as _i585;
import 'screens/company_offers/presentation/manager/company_offers_cubit.dart'
    as _i304;
import 'screens/company_profile/data/data_sources/remote/company_details_ds.dart'
    as _i559;
import 'screens/company_profile/data/data_sources/remote/company_details_ds_impl.dart'
    as _i168;
import 'screens/company_profile/data/repositories/company_details_repo_impl.dart'
    as _i545;
import 'screens/company_profile/domain/repositories/company_details_repo.dart'
    as _i259;
import 'screens/company_profile/domain/use_cases/company_details_use_case.dart'
    as _i226;
import 'screens/company_profile/presentation/manager/company_details_cubit.dart'
    as _i71;
import 'screens/company_rating_and_notification/rating_company/data/data_sources/rating_ds.dart'
    as _i962;
import 'screens/company_rating_and_notification/rating_company/data/data_sources/rating_ds_impl.dart'
    as _i1045;
import 'screens/company_rating_and_notification/rating_company/domain/repositories/rating_repo.dart'
    as _i2;
import 'screens/company_rating_and_notification/rating_company/domain/repositories/rating_repo_impl.dart'
    as _i32;
import 'screens/company_rating_and_notification/rating_company/domain/use_cases/rating_use_case.dart'
    as _i736;
import 'screens/company_rating_and_notification/rating_company/presentation/manager/rating_cubit.dart'
    as _i480;
import 'screens/event_details/data/data_source/remote/event_details_ds.dart'
    as _i470;
import 'screens/event_details/data/data_source/remote/event_details_ds_impl.dart'
    as _i296;
import 'screens/event_details/data/repositories/event_details_repo_impl.dart'
    as _i631;
import 'screens/event_details/domain/repositories/event_details_repo.dart'
    as _i132;
import 'screens/event_details/domain/use_cases/event_details_use_case.dart'
    as _i1051;
import 'screens/event_details/presentation/manager/event_details_cubit.dart'
    as _i574;
import 'screens/events_details/data/data_sources/remote/event_details_ds.dart'
    as _i874;
import 'screens/events_details/data/data_sources/remote/event_details_ds_impl.dart'
    as _i570;
import 'screens/events_details/data/repositories/event_details_repo_impl.dart'
    as _i727;
import 'screens/events_details/domain/repositories/event_details_repo.dart'
    as _i617;
import 'screens/events_details/domain/use_cases/event_details_use_case.dart'
    as _i1066;
import 'screens/events_details/presentation/manager/event_details_cubit.dart'
    as _i661;
import 'screens/newest_view_all/data/remote/data_sources/all_newest_ds.dart'
    as _i1036;
import 'screens/newest_view_all/data/remote/data_sources/all_newest_ds_impl.dart'
    as _i975;
import 'screens/newest_view_all/data/repositories/all_newest_repo_impl.dart'
    as _i342;
import 'screens/newest_view_all/domain/repositories/all_newest_repo.dart'
    as _i601;
import 'screens/newest_view_all/domain/use_cases/all_newest_use_case.dart'
    as _i907;
import 'screens/newest_view_all/presentation/manager/all_newest_cubit.dart'
    as _i1016;
import 'screens/payment/data/data_sources/remote/client_secret_ds.dart' as _i25;
import 'screens/payment/data/data_sources/remote/client_secret_ds_impl.dart'
    as _i399;
import 'screens/payment/data/repositories/client_secret_repo_impl.dart'
    as _i425;
import 'screens/payment/domain/repositories/client_secret_repo.dart' as _i437;
import 'screens/payment/domain/use_cases/payment_use_case.dart' as _i601;
import 'screens/payment/presentation/cubit/payment_cubit.dart' as _i500;
import 'screens/search/data/data_sources/remote/search_ds.dart' as _i845;
import 'screens/search/data/data_sources/remote/search_ds_impl.dart' as _i315;
import 'screens/search/data/repositories/search_repo_impl.dart' as _i594;
import 'screens/search/domain/repositories/search_repo.dart' as _i1006;
import 'screens/search/domain/use_cases/search_use_case.dart' as _i877;
import 'screens/search/presentation/manager/search_cubit.dart' as _i649;
import 'screens/tabs/home/data/data_sources/local/home_local_ds.dart' as _i882;
import 'screens/tabs/home/data/data_sources/local/home_local_ds_impl.dart'
    as _i852;
import 'screens/tabs/home/data/data_sources/local/recommendation_local_ds.dart'
    as _i384;
import 'screens/tabs/home/data/data_sources/local/recommendation_local_ds_impl.dart'
    as _i391;
import 'screens/tabs/home/data/data_sources/remote/home_ds.dart' as _i324;
import 'screens/tabs/home/data/data_sources/remote/home_ds_impl.dart' as _i821;
import 'screens/tabs/home/data/repositories/home_repo_impl.dart' as _i469;
import 'screens/tabs/home/domain/repositories/home_repo.dart' as _i810;
import 'screens/tabs/home/domain/use_cases/home_use_case.dart' as _i263;
import 'screens/tabs/home/presentation/manager/home_cubit.dart' as _i907;
import 'screens/tabs/offers/data/data_sources/local/companies_local_ds.dart'
    as _i88;
import 'screens/tabs/offers/data/data_sources/local/companies_local_ds_impl.dart'
    as _i32;
import 'screens/tabs/offers/data/data_sources/local/offers_local_ds.dart'
    as _i92;
import 'screens/tabs/offers/data/data_sources/local/offers_local_ds_impl.dart'
    as _i356;
import 'screens/tabs/offers/data/data_sources/remote/offers_ds.dart' as _i312;
import 'screens/tabs/offers/data/data_sources/remote/offers_ds_impl.dart'
    as _i583;
import 'screens/tabs/offers/data/repositories/offers_repo_impl.dart' as _i580;
import 'screens/tabs/offers/domain/repositories/offers_repo.dart' as _i193;
import 'screens/tabs/offers/domain/use_cases/offers_use_case.dart' as _i1011;
import 'screens/tabs/offers/presentation/manager/offers_cubit.dart' as _i727;
import 'screens/travel_filtration/data/data_sources/local/local_categories_ds.dart'
    as _i341;
import 'screens/travel_filtration/data/data_sources/local/local_categories_ds_impl.dart'
    as _i561;
import 'screens/travel_filtration/data/data_sources/remote/travel_category_ds.dart'
    as _i44;
import 'screens/travel_filtration/data/data_sources/remote/travel_category_ds_impl.dart'
    as _i107;
import 'screens/travel_filtration/data/repositories/travel_filter_repo_impl.dart'
    as _i779;
import 'screens/travel_filtration/domain/repositories/travel_filter_repo.dart'
    as _i805;
import 'screens/travel_filtration/domain/use_cases/travel_filter_use_case.dart'
    as _i1006;
import 'screens/travel_filtration/presentation/manger/travel_filter_cubit.dart'
    as _i615;
import 'screens/user_interaction/data/data_sources/local/hive_interaction_local_ds.dart'
    as _i996;
import 'screens/user_interaction/data/data_sources/remote/interaction_remote_ds.dart'
    as _i635;
import 'screens/user_interaction/data/models/di_module.dart' as _i864;
import 'screens/user_interaction/data/models/event_interaction_model.dart'
    as _i92;
import 'screens/user_interaction/data/repositories/interaction_repository_impl.dart'
    as _i59;
import 'screens/user_interaction/domain/repositories/interaction_repository.dart'
    as _i53;
import 'screens/user_interaction/domain/use_cases/save_interaction.dart'
    as _i945;
import 'screens/user_interaction/domain/use_cases/send_interactions.dart'
    as _i187;
import 'screens/user_interaction/presentation/manager/interaction_cubit.dart'
    as _i383;
import 'screens/view_all_events/data/data_sources/remote/all_events_ds.dart'
    as _i566;
import 'screens/view_all_events/data/data_sources/remote/all_events_ds_impl.dart'
    as _i164;
import 'screens/view_all_events/data/repositories/all_events_repo_impl.dart'
    as _i44;
import 'screens/view_all_events/domain/repositories/all_events_repo.dart'
    as _i438;
import 'screens/view_all_events/domain/use_cases/all_events_use_case.dart'
    as _i807;
import 'screens/view_all_events/presentation/manager/all_events_cubit.dart'
    as _i74;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final hiveBoxModule = _$HiveBoxModule();
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i979.Box<_i92.EventInteractionModel>>(
      () => hiveBoxModule.interactionBox,
      preResolve: true,
    );
    gh.lazySingleton<_i501.ApiManager>(() => _i501.ApiManager());
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.factory<_i559.CompanyDetailsDs>(
        () => _i168.CompanyDetailsDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i962.CompanyRatingDs>(
        () => _i1045.CompanyRatingDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i566.AllEventsDs>(
        () => _i164.AllEventsDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i419.AllTravelsLocalDs>(() => _i592.AllTravelsLocalDsImpl());
    gh.factory<_i483.NetworkInfo>(
        () => _i347.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.factory<_i438.AllEventsRepo>(
        () => _i44.AllEventsRepoImpl(gh<_i566.AllEventsDs>()));
    gh.factory<_i324.HomeDs>(() => _i821.HomeDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i341.LocalCategoriesDs>(() => _i561.LocalCategoriesDsImpl());
    gh.factory<_i219.AllDiscountsLocalDs>(
        () => _i793.AllDiscountsLocalDsImpl());
    gh.factory<_i842.AllTravelsDs>(
        () => _i665.AllTravelsDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i69.AllCompaniesDs>(
        () => _i200.AllCompaniesDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i845.SearchDs>(
        () => _i315.SearchDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i92.OffersLocalDs>(() => _i356.OffersLocalDsImpl());
    gh.factory<_i1036.AllNewestDs>(
        () => _i975.AllNewestDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i882.HomeLocalDs>(() => _i852.HomeLocalDsImpl());
    gh.factory<_i601.AllNewestRepo>(
        () => _i342.AllNewestRepoImpl(gh<_i1036.AllNewestDs>()));
    gh.factory<_i905.CompanyDiscountsDs>(
        () => _i536.CompanyDiscountsDsImpl(gh<_i501.ApiManager>()));
    gh.lazySingleton<_i635.InteractionRemoteDataSource>(
        () => _i635.InteractionRemoteDataSource(gh<_i501.ApiManager>()));
    gh.factory<_i44.TravelCategoryDs>(
        () => _i107.TravelCategoryDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i2.CompanyRatingRepo>(
        () => _i32.CompanyRatingRepoImpl(gh<_i962.CompanyRatingDs>()));
    gh.factory<_i631.AllCompaniesLocalDs>(
        () => _i496.AllCompaniesLocalDsImpl());
    gh.factory<_i907.AllNewestUseCase>(
        () => _i907.AllNewestUseCase(gh<_i601.AllNewestRepo>()));
    gh.factory<_i874.EventDetailsDs>(
        () => _i570.EventDetailsDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i384.RecommendationLocalDs>(
        () => _i391.RecommendationLocalDsImpl());
    gh.factory<_i617.EventDetailsRepo>(
        () => _i727.EventDetailsRepoImpl(gh<_i874.EventDetailsDs>()));
    gh.factory<_i61.BookingDs>(
        () => _i708.BookingDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i312.OffersDs>(
        () => _i583.OffersDsImpl(gh<_i501.ApiManager>()));
    gh.lazySingleton<_i996.HiveInteractionLocalDataSource>(() =>
        _i996.HiveInteractionLocalDataSourceImpl(
            gh<_i979.Box<_i92.EventInteractionModel>>()));
    gh.factory<_i991.BookingRepo>(
        () => _i659.BookingRepoImpl(gh<_i61.BookingDs>()));
    gh.factory<_i470.EventDetailsDs>(
        () => _i296.EventDetailsDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i88.CompaniesLocalDs>(() => _i32.CompaniesLocalDsImpl());
    gh.lazySingleton<_i1006.SearchRepo>(
        () => _i594.SearchRepoImpl(gh<_i845.SearchDs>()));
    gh.factory<_i529.AllDiscountsDs>(
        () => _i154.AllDiscountsDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i25.ClientSecretDs>(
        () => _i399.ClientSecretDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i814.CompanyDiscountsRepo>(
        () => _i351.CompanyDiscountsRepoImpl(gh<_i905.CompanyDiscountsDs>()));
    gh.factory<_i259.CompanyDetailsRepo>(
        () => _i545.CompanyDetailsRepoImpl(gh<_i559.CompanyDetailsDs>()));
    gh.factory<_i53.InteractionRepository>(() => _i59.InteractionRepositoryImpl(
          gh<_i996.HiveInteractionLocalDataSource>(),
          gh<_i635.InteractionRemoteDataSource>(),
        ));
    gh.factory<_i193.OffersRepo>(() => _i580.OffersRepoImpl(
          gh<_i312.OffersDs>(),
          gh<_i92.OffersLocalDs>(),
          gh<_i483.NetworkInfo>(),
          gh<_i88.CompaniesLocalDs>(),
        ));
    gh.factory<_i805.TravelFilterRepo>(() => _i779.TravelFilterRepoImpl(
          gh<_i44.TravelCategoryDs>(),
          gh<_i341.LocalCategoriesDs>(),
        ));
    gh.factory<_i585.CompanyDiscountsUseCase>(
        () => _i585.CompanyDiscountsUseCase(gh<_i814.CompanyDiscountsRepo>()));
    gh.factory<_i1016.AllNewestCubit>(
        () => _i1016.AllNewestCubit(gh<_i907.AllNewestUseCase>()));
    gh.factory<_i304.CompanyOffersCubit>(
        () => _i304.CompanyOffersCubit(gh<_i585.CompanyDiscountsUseCase>()));
    gh.factory<_i226.CompanyDetailsUseCase>(
        () => _i226.CompanyDetailsUseCase(gh<_i259.CompanyDetailsRepo>()));
    gh.factory<_i132.EventDetailsRepo>(
        () => _i631.EventDetailsRepoImpl(gh<_i470.EventDetailsDs>()));
    gh.factory<_i807.AllEventsUseCase>(
        () => _i807.AllEventsUseCase(gh<_i438.AllEventsRepo>()));
    gh.factory<_i795.AllTravelsRepo>(() => _i509.AllTravelsRepoImpl(
          gh<_i842.AllTravelsDs>(),
          gh<_i419.AllTravelsLocalDs>(),
          gh<_i483.NetworkInfo>(),
        ));
    gh.factory<_i847.AllCompaniesRepo>(() => _i297.AllCompaniesRepoImpl(
          gh<_i69.AllCompaniesDs>(),
          gh<_i631.AllCompaniesLocalDs>(),
          gh<_i483.NetworkInfo>(),
        ));
    gh.factory<_i617.BookingUseCase>(
        () => _i617.BookingUseCase(gh<_i991.BookingRepo>()));
    gh.factory<_i877.SearchUseCase>(
        () => _i877.SearchUseCase(gh<_i1006.SearchRepo>()));
    gh.factory<_i1006.TravelFilterUseCase>(
        () => _i1006.TravelFilterUseCase(gh<_i805.TravelFilterRepo>()));
    gh.factory<_i736.CompanyRatingUseCase>(
        () => _i736.CompanyRatingUseCase(gh<_i2.CompanyRatingRepo>()));
    gh.factory<_i74.AllEventsCubit>(
        () => _i74.AllEventsCubit(gh<_i807.AllEventsUseCase>()));
    gh.factory<_i591.AllDiscountsRepo>(() => _i438.AllDiscountsRepoImpl(
          gh<_i529.AllDiscountsDs>(),
          gh<_i219.AllDiscountsLocalDs>(),
          gh<_i483.NetworkInfo>(),
        ));
    gh.factory<_i880.AllTravelsUseCase>(
        () => _i880.AllTravelsUseCase(gh<_i795.AllTravelsRepo>()));
    gh.factory<_i44.AllTravelsCubit>(
        () => _i44.AllTravelsCubit(gh<_i880.AllTravelsUseCase>()));
    gh.factory<_i810.HomeRepo>(() => _i469.HomeRepoImpl(
          gh<_i324.HomeDs>(),
          gh<_i882.HomeLocalDs>(),
          gh<_i483.NetworkInfo>(),
          gh<_i384.RecommendationLocalDs>(),
        ));
    gh.factory<_i615.TravelFilterCubit>(
        () => _i615.TravelFilterCubit(gh<_i1006.TravelFilterUseCase>()));
    gh.factory<_i344.BookingCubit>(
        () => _i344.BookingCubit(bookingUseCase: gh<_i617.BookingUseCase>()));
    gh.factory<_i1066.EventDetailsUseCase>(
        () => _i1066.EventDetailsUseCase(gh<_i617.EventDetailsRepo>()));
    gh.factory<_i1051.EventDetailsUseCase>(
        () => _i1051.EventDetailsUseCase(gh<_i132.EventDetailsRepo>()));
    gh.factory<_i437.ClientSecretRepo>(
        () => _i425.ClientSecretRepoImpl(gh<_i25.ClientSecretDs>()));
    gh.factory<_i945.SaveInteractionUseCase>(
        () => _i945.SaveInteractionUseCase(gh<_i53.InteractionRepository>()));
    gh.factory<_i187.SendInteractionsUseCase>(
        () => _i187.SendInteractionsUseCase(gh<_i53.InteractionRepository>()));
    gh.factory<_i649.SearchCubit>(
        () => _i649.SearchCubit(gh<_i877.SearchUseCase>()));
    gh.factory<_i1011.OffersUseCase>(
        () => _i1011.OffersUseCase(gh<_i193.OffersRepo>()));
    gh.factory<_i383.InteractionCubit>(
        () => _i383.InteractionCubit(gh<_i945.SaveInteractionUseCase>()));
    gh.factory<_i71.CompanyDetailsCubit>(
        () => _i71.CompanyDetailsCubit(gh<_i226.CompanyDetailsUseCase>()));
    gh.factory<_i480.CompanyRatingCubit>(
        () => _i480.CompanyRatingCubit(gh<_i736.CompanyRatingUseCase>()));
    gh.factory<_i263.HomeUseCase>(
        () => _i263.HomeUseCase(gh<_i810.HomeRepo>()));
    gh.factory<_i903.AllCompaniesUseCase>(
        () => _i903.AllCompaniesUseCase(gh<_i847.AllCompaniesRepo>()));
    gh.factory<_i601.PaymentUseCase>(
        () => _i601.PaymentUseCase(gh<_i437.ClientSecretRepo>()));
    gh.factory<_i500.PaymentCubit>(
        () => _i500.PaymentCubit(paymentUseCase: gh<_i601.PaymentUseCase>()));
    gh.factory<_i40.AllComCubit>(() =>
        _i40.AllComCubit(allCompaniesUseCase: gh<_i903.AllCompaniesUseCase>()));
    gh.factory<_i750.AllDiscountsUseCase>(
        () => _i750.AllDiscountsUseCase(gh<_i591.AllDiscountsRepo>()));
    gh.factory<_i727.OffersCubit>(
        () => _i727.OffersCubit(offersUseCase: gh<_i1011.OffersUseCase>()));
    gh.factory<_i661.EventDetailsCubit>(
        () => _i661.EventDetailsCubit(gh<_i1066.EventDetailsUseCase>()));
    gh.factory<_i574.EventDetailsCubit>(
        () => _i574.EventDetailsCubit(gh<_i1051.EventDetailsUseCase>()));
    gh.factory<_i907.HomeCubit>(() => _i907.HomeCubit(gh<_i263.HomeUseCase>()));
    gh.factory<_i230.AllDiscountsCubit>(
        () => _i230.AllDiscountsCubit(gh<_i750.AllDiscountsUseCase>()));
    return this;
  }
}

class _$HiveBoxModule extends _i864.HiveBoxModule {}

class _$RegisterModule extends _i1017.RegisterModule {}
