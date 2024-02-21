import 'package:flutter/material.dart';

import 'cart_manager.dart';
import 'cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartMangaer();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          CartSummarry(
            cart: cart,
            onOrderNowPressed: () {
              print('An order has been added');
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: CartItemList(cart),
          ),
        ],
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList(this.cart, {super.key});
  final CartMangaer cart;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) =>
                CartItemCart(productId: entry.key, cartItem: entry.value),
          )
          .toList(),
    );
  }
}

class CartSummarry extends StatelessWidget {
  const CartSummarry({
    super.key,
    required this.cart,
    this.onOrderNowPressed,
  });

  final CartMangaer cart;
  final void Function()? onOrderNowPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '\$${cart.totalAmount.toStringAsFixed(2)}',
                style: Theme.of(context).primaryTextTheme.titleLarge,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            TextButton(
              onPressed: onOrderNowPressed,
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: const Text('ORDER NOW'),
            )
          ],
        ),
      ),
    );
  }
}