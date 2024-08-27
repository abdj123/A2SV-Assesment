import 'package:dartz/dartz.dart';

import 'package:groceries_app/core/error/failure.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';
import 'package:groceries_app/features/domain/repositories/products_repository.dart';

class GetAllPeoductUseCase {
  final ProductRepository productRepository;
  GetAllPeoductUseCase({
    required this.productRepository,
  });
  Future<Either<Failure, List<ProductEntity>>> execute() async {
    return await productRepository.getAllProducts();
  }
}
