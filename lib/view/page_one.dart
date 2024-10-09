import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/json.dart';
import 'package:e_commerce/view/cart_page.dart';
import 'package:e_commerce/view/profile.dart';
import 'package:e_commerce/view/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatelessWidget {
  final ProductController shopController = Get.put(ProductController());

  ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Products',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        actions: [
          PopupMenuButton<Category>(
            color: Colors.blue[100],
            onSelected: (Category value) {
              shopController.filterProductsByCategory(value);
            },
            itemBuilder: (BuildContext context) {
              return Category.values.map((Category category) {
                return PopupMenuItem<Category>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.category,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(CartPage());
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.shopping_cart,
                  size: 26,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(const ProfilePage());
            },
            icon: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(
                size: 26,
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.pinkAccent,
                        Colors.orangeAccent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "🔥 Flash Sale: Up to 50% OFF on selected items! 🛒",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 130,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: shopController.filteredProducts.length,
                  itemBuilder: (context, index) {
                    JsonDart product = shopController.filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailPage(product: product));
                      },
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                product.title,
                                style: const TextStyle(fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
