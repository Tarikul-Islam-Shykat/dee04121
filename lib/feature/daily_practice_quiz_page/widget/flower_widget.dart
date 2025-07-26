import 'package:flutter/material.dart';
import 'package:prettyrini/core/const/image_path.dart';

class FlowerNumberWidget extends StatelessWidget {
  final int number;
  final double? size;

  const FlowerNumberWidget({
    Key? key,
    required this.number,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate size based on number of digits for better readability
    final digits = number.toString().length;
    final calculatedSize = size ?? (80.0 + (digits * 5.0));

    return Container(
      width: calculatedSize,
      height: calculatedSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Your flower image
          Image.asset(
            ImagePath.add_flower,
            width: calculatedSize,
            height: calculatedSize,
            fit: BoxFit.contain,
          ),
          // Number in center
          Text(
            number.toString(),
            style: TextStyle(
              fontSize: calculatedSize * 0.25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
