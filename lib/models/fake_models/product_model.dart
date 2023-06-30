import 'package:flutter/material.dart';

class FakeProductModel {
  String name;
  String description;
  bool isWishlisted;
  bool isAddedToCart;
  int cartCount;
  double rating;
  ImageProvider<Object> productImage;
  int selectedColorIndex;
  List<String> availableSizes;
  int selectedSizeIndex;
  FakeProductModel({
    required this.name,
    required this.description,
    this.isWishlisted = false,
    this.isAddedToCart = false,
    this.cartCount = 1,
    required this.rating,
    required this.productImage,
    this.selectedColorIndex = 0,
    required this.availableSizes,
    this.selectedSizeIndex = 0,
  });
}
