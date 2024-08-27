import '../../domain/entities/options_entity.dart';

class OptionModel extends OptionEntity {
  const OptionModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  OptionEntity toEntity() => OptionEntity(id: id, name: name, price: price);
  OptionModel fromEntity(OptionEntity entity) =>
      OptionModel(id: entity.id, name: entity.name, price: entity.price);
}
