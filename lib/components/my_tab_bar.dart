import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key, required this.tabController});
  List<Tab> _buildCategoryTabs() {
    return FoodCategories.values.map((Category) {
      return Tab(
        text: Category.toString().split(".").last,
      );
    }).toList();
  }

  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(controller: tabController, tabs: _buildCategoryTabs()),
    );
  }
}
