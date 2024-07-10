import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/model/product_model.dart';
import 'package:wishlist/page/wishlist_page.dart';
import 'package:wishlist/provider/wishlist_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Page",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistPage(),
                ),
              );
            },
            child: const Text("Wishlist"),
          ),
        ],
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.productList.length,
            itemBuilder: (context, index) {
              var product = value.productList[index];
              return ListTile(
                title: Text(product.productTitle),
                trailing: IconButton(
                  onPressed: () async {
                    String responseMessage;
                    var updatedProduct = ProductModel(
                        productId: product.productId,
                        productTitle: product.productTitle,
                        isWishlisted: !product.isWishlisted);
                    if (!product.isWishlisted) {
                      responseMessage =
                          await value.addToWishList(updatedProduct);
                    } else {
                      responseMessage =
                          await value.removeFromWishList(updatedProduct);
                    }
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(responseMessage)));
                  },
                  icon: Icon(
                    product.isWishlisted
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
