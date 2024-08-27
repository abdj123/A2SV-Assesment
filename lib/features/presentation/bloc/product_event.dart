part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProductEvent extends ProductEvent {}

final class GetSingleProductEvent extends ProductEvent {
  final String id;

  const GetSingleProductEvent(this.id);
}
