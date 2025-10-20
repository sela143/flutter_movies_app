import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double voteAverage;
  final double starSize;

  const StarRating({
    super.key,
    required this.voteAverage,
    this.starSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    // convert from 10 → 5 scale
    double rating = (voteAverage / 10) * 5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: starSize);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: Colors.amber, size: starSize);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: starSize);
        }
      }),
    );
  }
}
