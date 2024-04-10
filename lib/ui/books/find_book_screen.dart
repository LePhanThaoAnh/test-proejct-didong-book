import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart'; // Import model book
import '../../ui/books/books_manager.dart'; // Import BooksManager
import '../shared/app_drawer.dart';

class FindBookScreen extends StatelessWidget {
  static const routeName = '/search';

  const FindBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _searchBooks(String searchText, BuildContext context) async {
      try {
        final booksManager = Provider.of<BooksManager>(context, listen: false);
        final List<Book> searchResult =
            await booksManager.searchBooksByName(searchText);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                SearchResultScreen(searchResult: searchResult),
          ),
        );
      } catch (e) {
        print(e);
      }
    }

    TextEditingController _searchController = TextEditingController();

    void _onSearchButtonPressed() {
      String searchText = _searchController.text;
      _searchBooks(searchText, context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tìm kiếm',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Tìm kiếm tên sách',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _onSearchButtonPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultScreen extends StatelessWidget {
  final List<Book> searchResult;

  const SearchResultScreen({Key? key, required this.searchResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          final book = searchResult[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            leading: Image.network(
              book.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            onTap: () {
              // Handle when a book is tapped
            },
          );
        },
      ),
    );
  }
}
