import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_quantity.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // food image
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              cartItem.Food.imagePath,
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // name and price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.Food.name,
                            ),
                            // food price
                            Text("₹${cartItem.Food.price}")
                          ],
                        ),
                        Spacer(),
                        MyQuantity(
                          quantity: cartItem.qty,
                          Food: cartItem.Food,
                          onIncrement: () {
                            restaurant.addToCart(
                                cartItem.Food, cartItem.selectedAddons);
                          },
                          onDecrement: () {
                            restaurant.removeFromCart(cartItem);
                          },
                        )
                      ],

                      // increment and decrement qty
                    ),
                  ),
                  SizedBox(
                    height: cartItem.selectedAddons.isEmpty ? 0 : 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 10, right: 10),
                      children: cartItem.selectedAddons
                          .map(
                            (addon) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: FilterChip(
                                label: Row(
                                  children: [
                                    // addon name
                                    Text("${addon.name} "),
                                    // addon price
                                    Text(
                                      "₹${addon.price}",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ],
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                onSelected: (value) {},
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                labelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  // addons
                ],
              ),
            ));
  }
}
