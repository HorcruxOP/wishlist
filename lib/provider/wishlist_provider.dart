import 'package:flutter/material.dart';
import 'package:wishlist/controller/api_controller.dart';
import 'package:wishlist/model/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> wishList = [];
  List<ProductModel> productList = List.generate(
    10,
    (index) => ProductModel(
      productId: index + 1,
      productTitle: "Product ${index + 1}",
    ),
  );

  Future<String> addToWishList(ProductModel product) async {
    int index = productList.indexWhere(
      (element) => element.productId == product.productId,
    );
    productList.removeAt(index);
    productList.insert(index, product);
    wishList.add(product);
    var responseMessage =
        await ApiController.addRemoveWishList(product.productId);
    notifyListeners();
    return responseMessage!;
  }

  Future<String> removeFromWishList(ProductModel product) async {
    int indexP = productList.indexWhere(
      (element) => element.productId == product.productId,
    );
    int indexW = wishList.indexWhere(
      (element) => element.productId == product.productId,
    );
    productList.removeAt(indexP);
    productList.insert(indexP, product);
    wishList.removeAt(indexW);
    var responseMessage =
        await ApiController.addRemoveWishList(product.productId);
    notifyListeners();
    return responseMessage!;
  }
}
