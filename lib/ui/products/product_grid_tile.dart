import 'package:flutter/material.dart';
import 'package:myshop/ui/products/product_detail_screen.dart';

import '../../../models/product.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: ProductGridFooter(
          product: product,
          // onFavoritePressed: () {
          //   print('Toggle a favorite product');
          // },
          onAddToCartPressed: () {
            print('Add item to cart');
          },
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ProductGridFooter extends StatefulWidget {
  const ProductGridFooter({
    super.key,
    required this.product,
    // this.onFavoritePressed,
    this.onAddToCartPressed,
  });

  final Product product;
  // final void Function()? onFavoritePressed;
  final void Function()? onAddToCartPressed;

  @override
  State<ProductGridFooter> createState() => _ProductGridFooterState();
}

class _ProductGridFooterState extends State<ProductGridFooter> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
      leading: IconButton(
        icon: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
        color: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          setState(() {
            _isFavorite = !_isFavorite;
          });
        },
      ),
      title: Text(
        widget.product.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.shopping_cart,
        ),
        onPressed: widget.onAddToCartPressed,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
