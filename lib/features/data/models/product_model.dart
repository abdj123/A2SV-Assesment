import 'package:groceries_app/features/data/models/option_model.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.imageUrl,
      required super.rating,
      required super.price,
      required super.discount,
      required super.options});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      options: (json['options'] as List)
          .map((option) => OptionModel.fromJson(option))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
      'discount': discount,
      'options':
          options.map((option) => (option as OptionModel).toJson()).toList(),
    };
  }

  static ProductModel fromEntity(ProductEntity entity) => ProductModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      rating: entity.rating,
      price: entity.price,
      discount: entity.discount,
      options: entity.options);

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        description: description,
        imageUrl: imageUrl,
        rating: rating,
        price: price,
        discount: discount,
        options: options
            .map((option) => (option as OptionModel).toEntity())
            .toList(),
      );
}
