class JsonDart {
  int id;
  String title;
  double price;
  String description;
  Category category;
  String image;
  Rating rating;

  JsonDart({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory JsonDart.fromJson(Map<String, dynamic> json) {
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
  }

  static Category _parseCategory(String category) {
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

enum Category {
  All,
  electronics,
  jewelery,
  mensClothing,
  womensClothing,
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });
}
