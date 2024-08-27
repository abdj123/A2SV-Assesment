import 'package:groceries_app/features/data/data_sources/remote_data_sources.dart';
import 'package:groceries_app/features/data/models/option_model.dart';
import 'package:groceries_app/features/data/models/product_model.dart';
import 'package:groceries_app/features/domain/repositories/products_repository.dart';
import 'package:groceries_app/features/domain/use_cases/get_all_peoduct_use_case.dart';
import 'package:groceries_app/features/domain/use_cases/get_single_product_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  ProductRepository,
  GetAllPeoductUseCase,
  GetSingleProductUseCase,
  ProductModel,
  OptionModel,
  RemoteDataSources,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

// generate mock
// dart run build_runner build