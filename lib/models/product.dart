import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id, title, productCategory, imageUrl, createdAt;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  Product({
    required this.id,
    required this.title,
    required this.productCategory,
    required this.imageUrl,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
    required this.isPiece,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'productCategory': productCategory,
      'imageUrl': imageUrl,
      'price': price,
      'salePrice': salePrice,
      'isOnSale': isOnSale,
      'isPiece': isPiece,
      'createdAt': createdAt,
    };
  }

  Map<String, dynamic> toJsonWithNewImage({required String newImageUrl}) {
    return {
      'id': id,
      'title': title,
      'productCategory': productCategory,
      'imageUrl': newImageUrl,
      'price': price,
      'salePrice': salePrice,
      'isOnSale': isOnSale,
      'isPiece': isPiece,
      'createdAt': createdAt,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      productCategory: json['productCategory'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      salePrice: json['salePrice'],
      isOnSale: json['isOnSale'],
      isPiece: json['isPiece'],
      createdAt: json['createdAt'],
    );
  }
}
