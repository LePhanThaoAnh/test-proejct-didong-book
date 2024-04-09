import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../shared/app_drawer.dart';
import '../cart/cart_manager.dart';
import '../cart/cart_screen.dart';
import 'books_manager.dart';
import 'package:provider/provider.dart';
import 'top_right_badge.dart';

class BookDetailScreen extends StatefulWidget {
  BookDetailScreen(
    this.book, {
    super.key,
  });

  static const routeName = '/book-detail';

  final Book book;

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
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
        title: Text(widget.book.title),
        actions: <Widget>[
          FavoriteButton(
            book: widget.book,
            onFavoritePressed: () {
              // Nghịch đảo giá trị isFavorite của book
              context.read<BooksManager>().toggleFavoriteStatus(widget.book);
            },
          ),
          HomeButton(
            onPressed: () {
              // Chuyển đến trang Home
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(widget.book.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.book.price}' + ' vnđ',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Số lượng:' + '${widget.book.quantity}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Tác giả: ' + widget.book.author,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Thể loại: ' + widget.book.category,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                widget.book.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                    onPressed: _decreaseCount, child: const Icon(Icons.remove)),
                Text(
                  '$_count',
                ),
                ElevatedButton(
                    onPressed: _increaseCount, child: const Icon(Icons.add)),
              ],
            ),
            ShoppingButton(
              onAddToCartPressed: () {
                // Đọc ra CartManager dùng context.read
                final cart = context.read<CartManager>();
                cart.addItem(widget.book);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Item added to cart',
                      ),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          // Xóa book nếu undo
                          cart.removeItem(widget.book.id!);
                        },
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.book,
    this.onFavoritePressed,
  });

  final void Function()? onFavoritePressed;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
        leading: ValueListenableBuilder<bool>(
      valueListenable: book.isFavoriteListenable,
      builder: (ctx, isFavorite, child) {
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
          ),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: onFavoritePressed,
        );
      },
    ));
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.shop,
      ),
      onPressed: onPressed,
    );
  }
}

class ShoppingButton extends StatelessWidget {
  const ShoppingButton({
    super.key,
    this.onPressed,
    this.onAddToCartPressed,
  });

  final void Function()? onAddToCartPressed;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.shopping_cart,
      ),
      onPressed: onAddToCartPressed,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
