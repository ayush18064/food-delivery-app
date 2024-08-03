// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: camel_case_types
class food {
  final String name; // cheese burger
  final String description; // a burger full of cheese
  final String imagePath; // the lib/images/cheeseburger
  final double price; // 4.99
  final FoodCategories category; // birger
  List<AddOn> availableAddOns;

  food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.availableAddOns,
    required this.category,
  });
}

// food categories
enum FoodCategories {
  burgers,
  salads,
  sides,
  desserts,
  drinks,
}

// food addons
class AddOn {
  String name;
  double price;
  AddOn({
    required this.name,
    required this.price,
  });
}
