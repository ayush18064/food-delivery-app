import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      padding: EdgeInsets.all(25),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // delivery fee
          Column(
            children: [
              Text("₹150"),
              Text("Delivery Fee"),
            ],
          ),

          Column(
            children: [
              Text("15-30 mins"),
              Text("Delivery time"),
            ],
          ),
        ],
      ),
    );
  }
}
