import 'package:flutter/material.dart';
import 'package:myshop/ui/books/book_detail_screen.dart';
import '../../models/book.dart';
import 'package:provider/provider.dart';
import '../cart/cart_manager.dart';
import 'books_manager.dart';

class BookGridTile extends StatelessWidget {
  const BookGridTile(
    this.book, {
    super.key,
  });
  final Book book;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: BookGridFooter(
          book: book,
          onFavoritePressed: () {
            // Nghịch đảo giá trị isFavorite của book
            context.read<BooksManager>().toggleFavoriteStatus(book);
          },
          onAddToCartPressed: () {
            // Đọc ra CartManager dùng context.read
            final cart = context.read<CartManager>();
            cart.addItem(book);
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
                      cart.removeItem(book.id!);
                    },
                  ),
                ),
              );
          },
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              BookDetailScreen.routeName,
              arguments: book.id,
            );
          },
          child: Image.network(
            book.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class BookGridFooter extends StatelessWidget {
  final Book book;
  final void Function()? onFavoritePressed;
  final void Function()? onAddToCartPressed;
  const BookGridFooter({
    super.key,
    required this.book,
    this.onFavoritePressed,
    this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
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
      ),
      title: Text(
        book.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.shopping_cart,
        ),
        onPressed: onAddToCartPressed,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
