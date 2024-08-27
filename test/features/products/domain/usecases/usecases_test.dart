import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groceries_app/core/error/failure.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';
import 'package:groceries_app/features/domain/use_cases/get_all_peoduct_use_case.dart';
import 'package:groceries_app/features/domain/use_cases/get_single_product_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helpers/test_helper.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late GetAllPeoductUseCase getAllPeoductUseCase;
  late GetSingleProductUseCase getSingleProductUseCase;

  setUp(
    () {
      mockProductRepository = MockProductRepository();
      getSingleProductUseCase =
          GetSingleProductUseCase(productRepository: mockProductRepository);
      getAllPeoductUseCase =
          GetAllPeoductUseCase(productRepository: mockProductRepository);
    },
  );

  const tProductId = '66be460f71fccd1506882d24';
  const tProduct = ProductEntity(
    id: tProductId,
    title: 'Chicken Burger',
    description: 'A delicious chicken burger...',
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723747446/assessment/xhvgqvpt7pghwaeqnids.jpg',
    rating: 4.9,
    price: 11.0,
    discount: 6.0,
    options: [],
  );

  final tProductList = [tProduct];

  group(
    "get Single Product",
    () {
      test(
          'should return ProductEntity when the call to the repository is successful',
          () async {
        // Arrange
        when(mockProductRepository.getProduct(any))
            .thenAnswer((_) async => const Right(tProduct));

        // Act
        final result = await getSingleProductUseCase.execute(tProductId);

        // Assert
        expect(result, const Right(tProduct));
        verify(mockProductRepository.getProduct(tProductId));
        verifyNoMoreInteractions(mockProductRepository);
      });

      test(
          'should return Failure when the call to the repository is unsuccessful',
          () async {
        // Arrange
        when(mockProductRepository.getProduct(any))
            .thenAnswer((_) async => const Left(ServerFailure("Server Error")));

        // Act
        final result = await getSingleProductUseCase.execute(tProductId);

        // Assert
        expect(result, const Left(ServerFailure("Server Error")));
        verify(mockProductRepository.getProduct(tProductId));
        verifyNoMoreInteractions(mockProductRepository);
      });
    },
  );

  group(
    "get all products",
    () {
      test(
        "Should return List of Products",
        () async {
          // Arrange
          when(mockProductRepository.getAllProducts())
              .thenAnswer((_) async => Right(tProductList));

          // Act
          final result = await getAllPeoductUseCase.execute();

          // Assert
          expect(result, Right(tProductList));
          verify(mockProductRepository.getAllProducts());
          verifyNoMoreInteractions(mockProductRepository);
        },
      );

      test(
        "should return Failure when the call to the repository is unsuccessful",
        () async {
          // Arrange
          when(mockProductRepository.getAllProducts()).thenAnswer((_) async =>
              const Left(ServerFailure("Faild to Fetch All Products")));

          // Act
          final result = await getAllPeoductUseCase.execute();

          // Assert
          expect(
              result, const Left(ServerFailure("Faild to Fetch All Products")));
          verify(mockProductRepository.getAllProducts());
          verifyNoMoreInteractions(mockProductRepository);
        },
      );
    },
  );
}
