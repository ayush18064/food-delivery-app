import 'package:flutter/material.dart';
import 'package:food_delivery/pages/cart_page.dart';

class MySliverAppbar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppbar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      collapsedHeight: 280,
      pinned: true,
      floating: false,
      actions: [
        // cart button
        IconButton(
          onPressed: () {
            // go to the cart page

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          icon: const Icon(Icons.shopping_cart),
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Sunset Dinner"),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 10),
        expandedTitleScale: 1,
      ),
    );
  }
}
