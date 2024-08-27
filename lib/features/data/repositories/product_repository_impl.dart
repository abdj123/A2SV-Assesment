import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:groceries_app/core/error/failure.dart';
import 'package:groceries_app/features/data/data_sources/remote_data_sources.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';
import 'package:groceries_app/features/domain/repositories/products_repository.dart';

import '../../../core/error/exception.dart';

class ProductRepositoryImpl extends ProductRepository {
  final RemoteDataSources remoteDataSources;

  ProductRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final result = await remoteDataSources.getAllProduct();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProduct(String id) async {
    try {
      final result = await remoteDataSources.getProductById(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
