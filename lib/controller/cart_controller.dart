import 'package:e_commerce/json.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <JsonDart, int>{}.obs;

  void addToCart(JsonDart product) {
    cartItems[product] = (cartItems[product] ?? 0) + 1;
  }

  void removeFromCart(JsonDart product) {
    cartItems.remove(product);
  }

  void increaseCount(JsonDart product) {
    cartItems[product] = (cartItems[product] ?? 0) + 1;
  }

  void decreaseCount(JsonDart product) {
    if (cartItems.containsKey(product)) {
      int count = cartItems[product]!;
      if (count > 1) {
        cartItems[product] = count - 1;
      } else {
        cartItems.remove(product);
      }
    }
  }

  void clearCart() {
    cartItems.clear();
  }
}
