import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu

  final List<food> _menu = [
    // burgers
    food(
      name: "Classic cheese burger",
      description:
          "a delicoous cheese filled burger, with melted cheddar,lettuce,tomatoes and a hint of onion and pickle ",
      imagePath: "lib/images/burgers/veg_burger.jpg",
      price: 149,
      availableAddOns: [
        AddOn(name: "Extra Cheese", price: 50),
        AddOn(name: "Extra mayonnaise", price: 70),
        AddOn(
          name: "avocado",
          price: 100,
        ),
      ],
      category: FoodCategories.burgers,
    ),
    food(
      name: "Classic bbq burger",
      description:
          "a delicoous cheese filled burger, with melted cheddar,lettuce,tomatoes and a hint of onion and pickle and bbq sauce ",
      imagePath: "lib/images/burgers/bbq_burger.jpg",
      price: 170,
      availableAddOns: [
        AddOn(name: "Extra Cheese", price: 50),
        AddOn(name: "Extra mayonnaise", price: 70),
        AddOn(
          name: "avocado",
          price: 100,
        ),
      ],
      category: FoodCategories.burgers,
    ),
    food(
      name: "Classic mexican burger",
      description:
          "a delicoous cheese filled burger, with melted cheddar,lettuce,tomatoes and jalapenos ",
      imagePath: "lib/images/burgers/mexican_burger.jpg",
      price: 200,
      availableAddOns: [
        AddOn(name: "Extra Cheese", price: 50),
        AddOn(name: "Extra mayonnaise", price: 70),
        AddOn(
          name: "avocado",
          price: 100,
        ),
      ],
      category: FoodCategories.burgers,
    ),
    food(
      name: "Classic large burger",
      description:
          "a delicoous cheese filled burger, with melted cheddar,lettuce,tomatoes and jalapenos ",
      imagePath: "lib/images/burgers/large_burger.jpg",
      price: 250,
      availableAddOns: [
        AddOn(name: "Extra Cheese", price: 50),
        AddOn(name: "Extra mayonnaise", price: 70),
        AddOn(
          name: "avocado",
          price: 100,
        ),
      ],
      category: FoodCategories.burgers,
    ),
    //salads

    //sides

    // desserts

    // drinks
  ];

  // G E T T E R S
  List<food> get menu => _menu;
  List<CartItem> get cart => _cart;

  // O P E R A T I O N S
// user cart
  List<CartItem> _cart = [];
// add to cart operation
  void addToCart(food Food, List<AddOn> selectedAddons) {
    // see if there is a cart item or not
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are same
      bool isSameFood = item.Food == Food;
      // check if the list of  selecte addons are the same
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });
    if (cartItem != null) {
      cartItem.qty++;
    }
    // otherwise add a new cart item
    else {
      _cart.add(CartItem(
        Food: Food,
        selectedAddons: selectedAddons,
      ));
    }
    notifyListeners();
  }

// remove from the cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].qty > 1) {
        _cart[cartIndex].qty--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

// get the total price of the cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.Food.price;
      for (AddOn addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.qty;
    }
    return total;
  }

// get the total number of items in the cart
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.qty;
    }
    return totalItemCount;
  }

// clear the cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
  // H E L P E R S

  // generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");
    receipt.writeln();

    // format the data to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln(
        "---------------------------------------------------------------------------------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.qty} x ${cartItem.Food.name}- ${_formatPrice(cartItem.Food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("  Add-ons: ${_formatAddons(cartItem.selectedAddons)} ");
      }
      receipt.writeln();
    }
    receipt.writeln(
        "---------------------------------------------------------------------------------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "₹${price.toStringAsFixed(2)}";
  }
  // format double value into money

  // format list of addons in to string summary
  String _formatAddons(List<AddOn> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(",");
  }
}
