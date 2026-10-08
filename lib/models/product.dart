import 'package:flutter/material.dart';

class Product {
  final String nama;
  final int harga;
  final IconData icon;

  Product({
    required this.nama,
    required this.harga,
    this.icon = Icons.shopping_bag,
  });
}