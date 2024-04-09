import 'package:flutter/material.dart';
import '../../models/book.dart';
import 'edit_book_screen.dart';
import 'books_manager.dart';
import 'package:provider/provider.dart';

class UserBookListTile extends StatelessWidget {
  final Book book;
  const UserBookListTile(
    this.book, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(book.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            EditUserBookButton(
              onPressed: () {
                // Chuyển đến trang EditBookScreen
                Navigator.of(context).pushNamed(
                  EditBookScreen.routeName,
                  arguments: book.id,
                );
              },
            ),
            DeleteUserBookButton(
              onPressed: () {
                // Đọc ra BooksManager để xóa book
                context.read<BooksManager>().deleteBook(book.id!);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Book deleted',
                        textAlign: TextAlign.center,
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

class DeleteUserBookButton extends StatelessWidget {
  const DeleteUserBookButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.error,
    );
  }
}

class EditUserBookButton extends StatelessWidget {
  const EditUserBookButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
