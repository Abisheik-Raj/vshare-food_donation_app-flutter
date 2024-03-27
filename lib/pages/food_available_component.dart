import "package:flutter/material.dart";
import "package:vshare/resources/Colors.dart";

class FoodAvailableComponent extends StatelessWidget {
  final String foodName;
  const FoodAvailableComponent({super.key, required this.foodName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: lighterGreenColor,
      ),
      child: Text(
        "$foodName",
        style: const TextStyle(
            color: Colors.white, fontFamily: "PoppinsSemiBold", fontSize: 33),
      ),
    );
  }
}
