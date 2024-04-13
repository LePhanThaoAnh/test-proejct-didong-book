import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../shared/app_drawer.dart';
import '../cart/cart_manager.dart';
import '../cart/cart_screen.dart';
import 'books_manager.dart';
import 'package:provider/provider.dart';
import 'top_right_badge.dart';
import 'package:intl/intl.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(widget.book.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.book.title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tác giả: ${widget.book.author}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Giá: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(widget.book.price)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Thể loại: ${widget.book.category} ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Số lượng: ${widget.book.quantity}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Giới thiệu: ${widget.book.description}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _decreaseCount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.zero, // Đặt borderRadius là zero
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Màu nền xám
                      borderRadius:
                          BorderRadius.zero, // Đặt borderRadius là zero
                      border:
                          Border.all(color: Colors.black, width: 1), // Border
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      '$_count',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _increaseCount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.zero, // Đặt borderRadius là zero
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200], // Màu nền xám
                  border: Border.all(color: Colors.grey[300]!), // Màu border
                ),
                child: IconButton(
                  onPressed: () {
                    // Code xử lý khi nhấn nút IconButton
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.black, // Màu của icon
                  ),
                ),
              ),
            )
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
