import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myshop/ui/auth/auth_manager.dart';
import '../auth/auth_manager.dart';
import '../orders/orders_screen.dart';
import '../cart/cart_screen.dart';
import '../books/user_books_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Books'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserBooksScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart Books'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}
