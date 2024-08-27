import 'package:equatable/equatable.dart';
import 'package:groceries_app/features/domain/entities/options_entity.dart';

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final double price;
  final double discount;
  final List<OptionEntity> options;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.discount,
    required this.options,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        rating,
        price,
        discount,
        options,
      ];
}
