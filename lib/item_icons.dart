import 'package:flutter/material.dart';

class ItemIcons extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int badgeCountBuah;
  final Function(Map<String, dynamic>) onItemAdded;

  const ItemIcons({
    required this.items,
    required this.badgeCountBuah,
    required this.onItemAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.notification_important),
        onPressed: () {},
      ),
    );
  }
}
