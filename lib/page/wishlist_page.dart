import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlist/model/product_model.dart';
import 'package:wishlist/provider/wishlist_provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wishlist Page",
        ),
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.wishList.length,
            itemBuilder: (context, index) {
              var product = value.wishList[index];
              return ListTile(
                title: Text(product.productTitle),
                trailing: IconButton(
                  onPressed: () async {
                    String responseMessage;
                    var updatedProduct = ProductModel(
                      productId: product.productId,
                      productTitle: product.productTitle,
                      isWishlisted: !product.isWishlisted,
                    );
                    responseMessage =
                        await value.removeFromWishList(updatedProduct);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(responseMessage)));
                  },
                  icon: const Icon(
                    Icons.favorite,
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
