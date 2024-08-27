class Urls {
  static const String baseUrl =
      "https://g5-flutter-learning-path-be.onrender.com/api/v1";

  static String getProduct(String id) => '$baseUrl/groceries/$id';

  static String getAllProducts = '$baseUrl/groceries';
}
