// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class CartItem {
  food Food;
  List<AddOn> selectedAddons;
  int qty;
  CartItem({
    required this.Food,
    required this.selectedAddons,
    this.qty = 1,
  });
  double get totalPrice {
    double addonsPrice =
        selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (Food.price + addonsPrice) * qty;
  }
}
