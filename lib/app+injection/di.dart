import 'package:base_structure/core/api/auth_interceptor.dart';
import 'package:base_structure/core/blocs/application_bloc/app_bloc.dart';
import 'package:base_structure/core/mediators/bloc_hub/concrete_hub.dart';
import 'package:base_structure/core/mediators/bloc_hub/hub.dart';
import 'package:base_structure/core/mediators/bloc_hub/members_key.dart';
import 'package:base_structure/core/services/image_picker_service.dart';
import 'package:base_structure/core/services/session_manager.dart';
import 'package:base_structure/core/services/theme_store.dart';
import 'package:base_structure/core/usecases/app_theme_usecases.dart';
import 'package:base_structure/core/usecases/check_first_initialize_usecase.dart';
import 'package:base_structure/data/datasources/exchage_data_source/exchange_data_source.dart';
import 'package:base_structure/data/repositories/exchange_reposotory_impl.dart';
import 'package:base_structure/domain/usecases/convert_exchange_use_case.dart';
import 'package:base_structure/domain/usecases/get_currencies_usecases.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/services/init_app_store.dart';
import '../data/datasources/exchage_data_source/exchange_data_source_impl.dart';
import '../domain/repositories/exchange_repository.dart';
import '../presentation/façades/app_facade.dart';
import '../presentation/flows/home_flow/bloc/home_bloc.dart';


final locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());

  locator.registerLazySingleton<ThemeStore>(() => ThemeStore());

  locator.registerLazySingleton<InitAppStore>(() => InitAppStore());

  locator.registerLazySingleton<SetAppThemeUseCase>(
      () => SetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<GetAppThemeUseCase>(
      () => GetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<CheckFirstInitUseCase>(
      () => CheckFirstInitUseCase(locator<InitAppStore>()));

  locator.registerLazySingleton<SetFirstTimeUseCase>(
      () => SetFirstTimeUseCase(locator<InitAppStore>()));

  locator.registerLazySingleton<SessionManager>(() => SessionManager());
  locator.registerFactory<Dio>(() => Dio());

  locator.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(locator<SessionManager>(), locator<Dio>()));





  locator.registerLazySingleton<AppUiFacade>(() => AppUiFacade(
        setAppThemeUseCase: locator<SetAppThemeUseCase>(),
        getAppThemeUseCase: locator<GetAppThemeUseCase>(),
        checkFirstInitUseCase: locator<CheckFirstInitUseCase>(),
        setFirstTimeUseCase: locator<SetFirstTimeUseCase>(),

      ));




  locator.registerLazySingleton<AppBloc>(
      () => AppBloc(appUiFacade: locator<AppUiFacade>()));

  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());


  locator
      .registerLazySingleton<ExchangeDataSource>(() => ExchangeDataSourceImpl());

  locator.registerLazySingleton<ExchangeRepository>(
      () => ExchangeRepositoryImpl(locator<ExchangeDataSource>()));

  locator.registerLazySingleton<GetCurrencyUseCase>(
      () => GetCurrencyUseCase(locator<ExchangeRepository>()));

  locator.registerLazySingleton(
      () => ConvertExchangeUseCase());



  locator.registerLazySingleton(() =>
      HomeBloc(locator<GetCurrencyUseCase>()));

  locator<BlocHub>().registerByName(locator<AppBloc>(), MembersKeys.appBloc);
  locator<BlocHub>()
      .registerByName(locator<HomeBloc>(), MembersKeys.exchangeBloc);

}

