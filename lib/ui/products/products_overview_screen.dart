import 'package:flutter/material.dart';
import 'package:myshop/ui/products/products_grid.dart';

import 'product_grid_tile.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          ProductFilterMenu(
            onFilterSelected: (filter) {
              setState(() {
                if (filter == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
          ),
          ShoppingCartButton(
            onPressed: () {
              print('Go to cart screen');
            },
          ),
        ],
      ),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}

class ProductFilterMenu extends StatelessWidget {
  const ProductFilterMenu({super.key, this.onFilterSelected});

  final void Function(FilterOptions selectedValue)? onFilterSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onFilterSelected,
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.shopping_cart,
      ),
    );
  }
}
