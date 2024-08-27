import 'package:dartz/dartz.dart';
import 'package:groceries_app/core/error/failure.dart';
import 'package:groceries_app/features/domain/repositories/products_repository.dart';

import '../entities/product_entity.dart';

class GetSingleProductUseCase {
  final ProductRepository productRepository;
  GetSingleProductUseCase({
    required this.productRepository,
  });
  Future<Either<Failure, ProductEntity>> execute(String id) async {
    return await productRepository.getProduct(id);
  }
}
