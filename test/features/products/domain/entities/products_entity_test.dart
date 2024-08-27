import 'package:flutter_test/flutter_test.dart';
import 'package:groceries_app/features/domain/entities/options_entity.dart';
import 'package:groceries_app/features/domain/entities/product_entity.dart';

void main() {
  group('ProductEntity', () {
    const option1 = OptionEntity(id: '1', name: 'Add Cheese', price: 0.5);
    const option2 = OptionEntity(id: '2', name: 'Add Bacon', price: 1.0);

    const product = ProductEntity(
      id: '66be460f71fccd1506882d24',
      title: 'Chicken Burger',
      description: 'A delicious chicken burger served on a toasted bun...',
      imageUrl:
          'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723747446/assessment/xhvgqvpt7pghwaeqnids.jpg',
      rating: 4.9,
      price: 11.0,
      discount: 6.0,
      options: [option1, option2],
    );

    test('should return correct props', () {
      expect(product.props, [
        '66be460f71fccd1506882d24',
        'Chicken Burger',
        'A delicious chicken burger served on a toasted bun...',
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723747446/assessment/xhvgqvpt7pghwaeqnids.jpg',
        4.9,
        11.0,
        6.0,
        [option1, option2],
      ]);
    });

    test('should be equal to another ProductEntity with the same values', () {
      const sameProduct = ProductEntity(
        id: '66be460f71fccd1506882d24',
        title: 'Chicken Burger',
        description: 'A delicious chicken burger served on a toasted bun...',
        imageUrl:
            'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723747446/assessment/xhvgqvpt7pghwaeqnids.jpg',
        rating: 4.9,
        price: 11.0,
        discount: 6.0,
        options: [option1, option2],
      );

      expect(product, equals(sameProduct));
    });

    test('should not be equal to a ProductEntity with different values', () {
      const differentProduct = ProductEntity(
        id: 'different_id',
        title: 'Beef Burger',
        description: 'A different description...',
        imageUrl:
            'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723747609/assessment/lna3djrzaqmlyoyfdeag.jpg',
        rating: 4.8,
        price: 12.0,
        discount: 10.0,
        options: [option1],
      );

      expect(product, isNot(equals(differentProduct)));
    });
  });

  group('OptionEntity', () {
    const option = OptionEntity(id: '1', name: 'Add Cheese', price: 0.5);

    test('should return correct props', () {
      expect(option.props, ['1', 'Add Cheese', 0.5]);
    });

    test('should be equal to another OptionEntity with the same values', () {
      const sameOption = OptionEntity(id: '1', name: 'Add Cheese', price: 0.5);

      expect(option, equals(sameOption));
    });

    test('should not be equal to an OptionEntity with different values', () {
      const differentOption =
          OptionEntity(id: '2', name: 'Add Bacon', price: 1.0);

      expect(option, isNot(equals(differentOption)));
    });
  });
}
