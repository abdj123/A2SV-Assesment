import 'package:get_it/get_it.dart';
import 'package:groceries_app/features/data/data_sources/remote_data_sources.dart';
import 'package:groceries_app/features/data/repositories/product_repository_impl.dart';
import 'package:groceries_app/features/domain/repositories/products_repository.dart';
import 'package:groceries_app/features/domain/use_cases/get_all_peoduct_use_case.dart';
import 'package:groceries_app/features/domain/use_cases/get_single_product_use_case.dart';
import 'package:groceries_app/features/presentation/bloc/product_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;
Future<void> setupLocator() async {
  locator.registerFactory(() => ProductBloc(locator(), locator()));

  // usecases
  locator.registerLazySingleton(
      () => GetSingleProductUseCase(productRepository: locator()));

  locator.registerLazySingleton(
      () => GetAllPeoductUseCase(productRepository: locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSources: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSources>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external

  locator.registerLazySingleton(() => http.Client());
}
