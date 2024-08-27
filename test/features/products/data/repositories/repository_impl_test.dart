import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groceries_app/core/error/exception.dart';
import 'package:groceries_app/core/error/failure.dart';
import 'package:groceries_app/features/data/models/option_model.dart';
import 'package:groceries_app/features/data/models/product_model.dart';
import 'package:groceries_app/features/data/repositories/product_repository_impl.dart';
import 'package:groceries_app/features/domain/entities/options_entity.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSources mockRemoteDataSources;
  late ProductRepositoryImpl productRepositoryImpl;

  setUp(
    () {
      mockRemoteDataSources = MockRemoteDataSources();
      productRepositoryImpl =
          ProductRepositoryImpl(remoteDataSources: mockRemoteDataSources);
    },
  );

  const optionModel = OptionModel(
    id: '66be474571fccd1506882d26',
    name: 'Add Cheese',
    price: 0.5,
  );

  const productModel = ProductModel(
    id: '66be460f71fccd1506882d24',
    title: 'Chicken Burger',
    description: 'A delicious chicken burger...',
    imageUrl: 'https://example.com/image.jpg',
    rating: 4.9,
    price: 11.0,
    discount: 6.0,
    options: [optionModel],
  );

  const productEntity = ProductEntity(
    id: '66be460f71fccd1506882d24',
    title: 'Chicken Burger',
    description: 'A delicious chicken burger...',
    imageUrl: 'https://example.com/image.jpg',
    rating: 4.9,
    price: 11.0,
    discount: 6.0,
    options: [
      OptionEntity(
        id: '66be474571fccd1506882d26',
        name: 'Add Cheese',
        price: 0.5,
      ),
    ],
  );

  const testProductId = '66be460f71fccd1506882d24';

  group(
    'get single product by id implementation',
    () {
      test(
        'should get single product with 200',
        () async {
          // arrange

          when(mockRemoteDataSources.getProductById(testProductId))
              .thenAnswer((realInvocation) async => productModel);

          // act

          final result = await productRepositoryImpl.getProduct(testProductId);

          // assert

          expect(result, equals(const Right(productEntity)));
        },
      );

      test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSources.getProductById(testProductId))
              .thenThrow(ServerException());

          // act
          final result = await productRepositoryImpl.getProduct(testProductId);

          // assert
          expect(result,
              equals(const Left(ServerFailure('An error has occurred'))));
        },
      );
    },
  );

  group(
    'get all products',
    () {
      test('should return a list of products when the call is successful',
          () async {
        // arrange
        when(mockRemoteDataSources.getAllProduct())
            .thenAnswer((_) async => [productModel]);

        // act
        final result = await productRepositoryImpl.getAllProducts();
        // assert
        expect(result, equals(const Right([productEntity])));
      });

      test('should return ServerFailure when the call is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSources.getAllProduct())
            .thenThrow(ServerException());

        // act
        final result = await productRepositoryImpl.getAllProducts();

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      });

      test(
          'should return ConnectionFailure when there is no internet connection',
          () async {
        // arrange
        when(mockRemoteDataSources.getAllProduct()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await productRepositoryImpl.getAllProducts();

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    },
  );
}
