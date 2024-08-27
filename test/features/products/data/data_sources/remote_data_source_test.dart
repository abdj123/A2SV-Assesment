import 'package:flutter_test/flutter_test.dart';
import 'package:groceries_app/core/constants/constants.dart';
import 'package:groceries_app/core/error/exception.dart';
import 'package:groceries_app/features/data/data_sources/remote_data_sources.dart';
import 'package:groceries_app/features/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'dart:convert';

import '../../../../test_helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = RemoteDataSourceImpl(client: mockHttpClient);
  });

  const testId = '66be460f71fccd1506882d24';

  const testProductModel2 = ProductModel(
    id: '66be460f71fccd1506882d25',
    title: 'Beef Burger',
    description: 'A delicious beef burger...',
    imageUrl: 'https://example.com/image2.jpg',
    rating: 4.8,
    price: 12.0,
    discount: 5.0,
    options: [],
  );

  const testProductModel = ProductModel(
    id: '66be460f71fccd1506882d24',
    title: 'Chicken Burger',
    description: 'A delicious chicken burger...',
    imageUrl: 'https://example.com/image.jpg',
    rating: 4.9,
    price: 11.0,
    discount: 6.0,
    options: [],
  );

  final List<ProductModel> testProductList = [
    testProductModel,
    testProductModel2
  ];

  group("get single product by id", () {
    test(
      'should perform a GET request on a URL with the product ID being the endpoint',
      () async {
        // arrange
        when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(
              json.encode({'data': testProductModel.toJson()}), 200),
        );

        // act
        await remoteDataSourceImpl.getProductById(testId);

        // assert
        verify(mockHttpClient.get(Uri.parse(Urls.getProduct(testId))));
      },
    );

    test(
      'should return ProductModel when the response code is 200 (success)',
      () async {
        // arrange
        when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(
              json.encode({'data': testProductModel.toJson()}), 200),
        );

        // act
        final result = await remoteDataSourceImpl.getProductById(testId);

        // assert
        expect(result, equals(testProductModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response('Something went wrong', 404),
        );

        // act
        final call = remoteDataSourceImpl.getProductById;

        // assert
        expect(() => call(testId), throwsA(isA<ServerException>()));
      },
    );
  });

  group(
    "get all products",
    () {
      test(
        'should perform a GET request on a URL to get all products',
        () async {
          // arrange
          when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(
                json.encode(
                    {'data': testProductList.map((p) => p.toJson()).toList()}),
                200),
          );

          // act
          await remoteDataSourceImpl.getAllProduct();

          // assert
          verify(mockHttpClient.get(Uri.parse(Urls.getAllProducts)));
        },
      );

      test(
        'should return a List of ProductModel when the response code is 200 (success)',
        () async {
          // arrange
          when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(
                json.encode(
                    {'data': testProductList.map((p) => p.toJson()).toList()}),
                200),
          );

          // act
          final result = await remoteDataSourceImpl.getAllProduct();

          // assert
          expect(result, equals(testProductList));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response('Something went wrong', 404),
          );

          // act
          final call = remoteDataSourceImpl.getAllProduct;

          // assert
          expect(() => call(), throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
