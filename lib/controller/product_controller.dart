import 'package:e_commerce/json.dart';
import 'package:e_commerce/model/api_network.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <JsonDart>[].obs;
  var filteredProducts = <JsonDart>[].obs;
  var selectedCategory = Category.All.obs;
  ApiProvider apiProvider = ApiProvider();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      List<JsonDart> fetchedProducts = await apiProvider.fetchProducts();
      products.assignAll(fetchedProducts);
      filterProductsByCategory(selectedCategory.value);
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void filterProductsByCategory(Category category) {
    print("Selected category: $category");

    selectedCategory.value = category;

    if (category == Category.All) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where((product) {
          print("Product category: ${product.category}");
          return product.category == category;
        }).toList(),
      );
    }

    print("Filtered products count: ${filteredProducts.length}");
  }
}
