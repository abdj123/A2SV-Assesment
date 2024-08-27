import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';
import 'package:groceries_app/features/domain/use_cases/get_all_peoduct_use_case.dart';
import 'package:groceries_app/features/domain/use_cases/get_single_product_use_case.dart';

import '../../data/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllPeoductUseCase getAllPeoductUseCase;
  final GetSingleProductUseCase getSingleProductUseCase;
  ProductBloc(this.getAllPeoductUseCase, this.getSingleProductUseCase)
      : super(ProductInitial()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getSingleProductUseCase.execute(event.id);
      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        emit(GetSingleProductState(data));
      });
    });
    on<GetAllProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getAllPeoductUseCase.execute();
      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        List<ProductModel> newProduct = [];
        // ignore: avoid_function_literals_in_foreach_calls
        data.forEach((el) async => newProduct.add(ProductModel.fromEntity(el)));

        emit(GetAllProductState(newProduct));
      });
    });
  }
}
