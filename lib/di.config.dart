// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'helpers/api_manager/api_manager.dart' as _i501;
import 'screens/booking/data/data_sources/remote/booking_ds.dart' as _i61;
import 'screens/booking/data/data_sources/remote/booking_ds_impl.dart' as _i708;
import 'screens/booking/data/repositories/booking_repo_impl.dart' as _i659;
import 'screens/booking/domain/repositories/booking_repo.dart' as _i991;
import 'screens/booking/domain/use_cases/booking_use_case.dart' as _i617;
import 'screens/booking/presentation/manager/booking_cubit.dart' as _i344;
import 'screens/payment/data/data_sources/remote/client_secret_ds.dart' as _i25;
import 'screens/payment/data/data_sources/remote/client_secret_ds_impl.dart'
    as _i399;
import 'screens/payment/data/repositories/client_secret_repo_impl.dart'
    as _i425;
import 'screens/payment/domain/repositories/client_secret_repo.dart' as _i437;
import 'screens/payment/domain/use_cases/payment_use_case.dart' as _i601;
import 'screens/payment/presentation/cubit/payment_cubit.dart' as _i500;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i500.PaymentCubit>(() => _i500.PaymentCubit());
    gh.lazySingleton<_i501.ApiManager>(() => _i501.ApiManager());
    gh.factory<_i61.BookingDs>(
        () => _i708.BookingDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i991.BookingRepo>(
        () => _i659.BookingRepoImpl(gh<_i61.BookingDs>()));
    gh.factory<_i25.ClientSecretDs>(
        () => _i399.ClientSecretDsImpl(gh<_i501.ApiManager>()));
    gh.factory<_i617.BookingUseCase>(
        () => _i617.BookingUseCase(gh<_i991.BookingRepo>()));
    gh.factory<_i344.BookingCubit>(
        () => _i344.BookingCubit(bookingUseCase: gh<_i617.BookingUseCase>()));
    gh.factory<_i437.ClientSecretRepo>(
        () => _i425.ClientSecretRepoImpl(gh<_i25.ClientSecretDs>()));
    gh.factory<_i601.PaymentUseCase>(
        () => _i601.PaymentUseCase(gh<_i437.ClientSecretRepo>()));
    return this;
  }
}
