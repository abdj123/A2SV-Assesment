part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class GetAllProductState extends ProductState {
  final List<ProductEntity> allProducts;

  const GetAllProductState(this.allProducts);
}

final class GetSingleProductState extends ProductState {
  final ProductEntity Product;

  const GetSingleProductState(this.Product);
}

final class LoadingState extends ProductState {}

final class ErrorState extends ProductState {
  final String message;

  const ErrorState(this.message);
}
