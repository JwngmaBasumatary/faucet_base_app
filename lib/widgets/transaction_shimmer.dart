import 'package:flutter/material.dart';

import 'ui/shimmer_card.dart';

class TransactionShimmer extends StatelessWidget {
  const TransactionShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.blueGrey,
      child: ListTile(
          title: const ShimmerCard(height: 12, width: 20),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: const [
                ShimmerCard(height: 16, width: 80, radius: 16),
                SizedBox(
                  width: 10,
                ),
                ShimmerCard(height: 16, width: 80, radius: 16),
              ],
            ),
          ),
          trailing: const ShimmerCard(height: 16, width: 80, radius: 16)),
    );
  }
}