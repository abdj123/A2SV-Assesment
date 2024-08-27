import 'package:flutter_test/flutter_test.dart';
import 'package:groceries_app/features/data/models/option_model.dart';
import 'package:groceries_app/features/data/models/product_model.dart';

void main() {
  const optionJson = {
    'id': '66be474571fccd1506882d26',
    'name': 'Add Cheese',
    'price': 0.5,
  };

  const productJson = {
    'id': '66be460f71fccd1506882d24',
    'title': 'Chicken Burger',
    'description':
        'A delicious chicken burger served on a toasted bun with fresh lettuce, tomato slices, and mayonnaise. Juicy grilled chicken patty seasoned to perfection for a mouthwatering taste experience.',
    'imageUrl':
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723747446/assessment/xhvgqvpt7pghwaeqnids.jpg',
    'rating': 4.9,
    'price': 11,
    'discount': 6,
    'options': [
      {
        'id': '66be474571fccd1506882d26',
        'name': 'Add Cheese',
        'price': 0.5,
      },
      {
        'id': '66be479671fccd1506882d28',
        'name': 'Add Bacon',
        'price': 1,
      },
      {
        'id': '66be47c671fccd1506882d29',
        'name': 'Add Meat',
        'price': 0,
      }
    ]
  };

  group('OptionModel', () {
    test('should convert from JSON correctly', () {
      final optionModel = OptionModel.fromJson(optionJson);

      expect(optionModel.id, optionJson['id']);
      expect(optionModel.name, optionJson['name']);
      expect(optionModel.price, optionJson['price']);
    });

    test('should convert to JSON correctly', () {
      const optionModel = OptionModel(
        id: '66be474571fccd1506882d26',
        name: 'Add Cheese',
        price: 0.5,
      );

      final result = optionModel.toJson();

      expect(result, optionJson);
    });
  });

  group('ProductModel', () {
    test('should convert from JSON correctly', () {
      final productModel = ProductModel.fromJson(productJson);

      expect(productModel.id, productJson['id']);
      expect(productModel.title, productJson['title']);
      expect(productModel.description, productJson['description']);
      expect(productModel.imageUrl, productJson['imageUrl']);
      expect(productModel.rating, productJson['rating']);
      expect(productModel.price, productJson['price']);
      expect(productModel.discount, productJson['discount']);
    });

    test('should convert to JSON correctly', () {
      const productModel = ProductModel(
        id: '66be460f71fccd1506882d24',
        title: 'Chicken Burger',
        description:
            'A delicious chicken burger served on a toasted bun with fresh lettuce, tomato slices, and mayonnaise. Juicy grilled chicken patty seasoned to perfection for a mouthwatering taste experience.',
        imageUrl:
            'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723747446/assessment/xhvgqvpt7pghwaeqnids.jpg',
        rating: 4.9,
        price: 11,
        discount: 6,
        options: [
          OptionModel(
            id: '66be474571fccd1506882d26',
            name: 'Add Cheese',
            price: 0.5,
          ),
          OptionModel(
            id: '66be479671fccd1506882d28',
            name: 'Add Bacon',
            price: 1,
          ),
          OptionModel(
            id: '66be47c671fccd1506882d29',
            name: 'Add Meat',
            price: 0,
          )
        ],
      );

      final result = productModel.toJson();

      expect(result, productJson);
    });
  });
}
