import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:groceries_app/features/data/models/product_model.dart';

import '../../../core/constants/constants.dart';
import '../../../core/error/exception.dart';

abstract class RemoteDataSources {
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getAllProduct();
}

class RemoteDataSourceImpl extends RemoteDataSources {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});
  @override
  Future<List<ProductModel>> getAllProduct() async {
    List<ProductModel> allProducts = [];
    final response = await client.get(
      Uri.parse(Urls.getAllProducts),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data['data']
          .forEach((el) async => {allProducts.add(ProductModel.fromJson(el))});
      return allProducts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get(
      Uri.parse(Urls.getProduct(id)),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProductModel.fromJson(data["data"]);
    } else {
      throw ServerException();
    }
  }
}
