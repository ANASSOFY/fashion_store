import 'package:flutter/material.dart';

// ================= Product Model =================
class ProductModel {
  final String imagePath;
  final String name;
  final double price;
  bool isFavorite;

  ProductModel({
    required this.imagePath,
    required this.name,
    required this.price,
    this.isFavorite = false,
  });
}

// ================= Men Products Data =================
final List<ProductModel> menProducts = [
  ProductModel(
    imagePath: 'assets/img/models/Cloth 1.png',
    name: 'Gray coat and white T-sh..',
    price: 30,
  ),
  ProductModel(
    imagePath: 'assets/img/models/Cloth 3.png',
    name: 'Gray coat and white T-sh..',
    price: 30,
  ),
  ProductModel(
    imagePath: 'assets/img/models/Frame 39928.png',
    name: 'Gray coat and white T-sh..',
    price: 30,
  ),
  ProductModel(
    imagePath: 'assets/img/models/Frame 39929.png',
    name: 'Top man black',
    price: 20,
  ),
  ProductModel(
    imagePath: 'assets/img/models/Cloth 1.png',
    name: 'Top man black with Trous..',
    price: 35,
  ),
];

// ================= Kids Products Data =================
final List<ProductModel> kidsProducts = [
  ProductModel(
    imagePath: 'assets/img/models/kid_1.jpeg',
    name: 'Little Gentleman Style',
    price: 22,
  ),
  ProductModel(
    imagePath: 'assets/img/models/kid_2.jpeg',
    name: 'Son white outfit',
    price: 18,
  ),
  ProductModel(
    imagePath: 'assets/img/models/kid_3.jpeg',
    name: 'Kids casual set',
    price: 15,
  ),
  ProductModel(
    imagePath: 'assets/img/models/kid_4.jpeg',
    name: 'Cute small boys outfit',
    price: 20,
  ),
  ProductModel(
    imagePath: 'assets/img/models/kid_5.jpeg',
    name: 'Vintage Suspender Style',
    price: 25,
  ),
];
