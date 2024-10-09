import 'dart:convert';
import 'package:e_commerce/json.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<List<JsonDart>> fetchProducts() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        List<JsonDart> fetchedProducts = jsonResponse.map((json) {
          return JsonDart(
            id: json['id'],
            title: json['title'],
            price: json['price'].toDouble(),
            description: json['description'],
            category: _parseCategory(json['category']),
            image: json['image'],
            rating: Rating(
              rate: json['rating']['rate'].toDouble(),
              count: json['rating']['count'],
            ),
          );
        }).toList();

        return fetchedProducts;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Category _parseCategory(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Category.electronics;
      case 'jewelery':
        return Category.jewelery;
      case 'men\'s clothing':
        return Category.mensClothing;
      case 'women\'s clothing':
        return Category.womensClothing;
      default:
        return Category.All;
    }
  }
}
