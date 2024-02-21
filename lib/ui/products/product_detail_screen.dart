import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen(
    this.product, {
    super.key,
  });
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _count = 0;

  void _increaseCount() {
    setState(() {
      _count++;
    });
  }

  void _decreaseCount() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.product.title),
          actions: <Widget>[
            FavoriteButton(
              onPressed: () {
                print('Go to favorite screen');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child:
                    Image.network(widget.product.imageUrl, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${widget.product.price}',
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  widget.product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: _decreaseCount,
                      child: const Icon(Icons.remove)),
                  Text(
                    '$_count',
                  ),
                  ElevatedButton(
                      onPressed: _increaseCount, child: const Icon(Icons.add)),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {},
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ));
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}
