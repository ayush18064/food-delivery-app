import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  FoodPage({super.key, required this.Food}) {
    // iniitalize a selected addons
    for (AddOn addon in Food.availableAddOns) {
      selectedAddons[addon] = false;
    }
  }
  final food Food;
  final Map<AddOn, bool> selectedAddons = {};
  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(food Food, Map<AddOn, bool> selectedAddons) {
    Navigator.pop(context);
    List<AddOn> currentlySelectedAddon = [];
    for (AddOn addon in widget.Food.availableAddOns) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddon.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(Food, currentlySelectedAddon);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // scafflod ui
        Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Image.asset(
                  widget.Food.imagePath,
                  height: 550,
                  width: double.infinity,
                ),
                //food name
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.Food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // food description
                      Text(
                        widget.Food.description,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "₹${widget.Food.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        indent: 5,
                        endIndent: 5,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      Text(
                        "Add-Ons",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      //add ons
                      ListView.builder(
                          itemCount: widget.Food.availableAddOns.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // get individual addons
                            AddOn addon = widget.Food.availableAddOns[index];
                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                "₹${addon.price}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              value: widget.selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          }),

                      MyButton(
                          text: "Add to cart",
                          onTap: () =>
                              addToCart(widget.Food, widget.selectedAddons)),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        // back button
        SafeArea(
          child: Opacity(
            opacity: 0.5,
            child: Container(
              margin: EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                onPressed: () => {Navigator.pop(context)},
              ),
            ),
          ),
        )
      ],
    );
  }
}
