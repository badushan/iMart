import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/json.dart';
import 'package:e_commerce/view/cart_page.dart';
import 'package:e_commerce/view/purchase_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatefulWidget {
  final JsonDart product;

  const ProductDetailPage({super.key, required this.product});

  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {
  bool _isExpanded = false;
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.product.image,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isExpanded
                    ? widget.product.description
                    : '${widget.product.description.substring(0, 100)}...',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Read Less' : 'Read More',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Price: \$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Rating: ${widget.product.rating.rate} (${widget.product.rating.count} votes)',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                ),
                onPressed: () {
                  cartController.addToCart(widget.product);
                  Get.snackbar(
                    'Success',
                    'Added to cart!',
                    snackPosition: SnackPosition.TOP,
                    mainButton: TextButton(
                      onPressed: () {
                        Get.to(CartPage());
                      },
                      child: const Text(
                        'Go to Cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(),
                  ),
                ),
                onPressed: () {
                  Get.to(() => const PurchaseSuccessPage());
                },
                child: const Text(
                  'Buy Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
