import 'package:flutter/material.dart';
import 'order_manager.dart';
import 'order_item_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersMangaer();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersManager.orderCount,
        itemBuilder: (ctx, i) => OrderItemCart(ordersManager.orders[i]),
      ),
    );
  }
}
