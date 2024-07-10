class ProductModel {
  final int productId;
  final String productTitle;
  final bool isWishlisted;

  ProductModel({
    required this.productId,
    required this.productTitle,
    this.isWishlisted = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productTitle': productTitle,
      'isWishlisted': isWishlisted,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as int,
      productTitle: map['productTitle'] as String,
      isWishlisted: map['isWishlisted'] as bool,
    );
  }
}
