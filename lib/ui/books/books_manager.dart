import '../../models/book.dart';
import '../../models/auth_token.dart';
import 'package:flutter/foundation.dart';
import '../../services/books_service.dart';

class BooksManager with ChangeNotifier {
  List<Book> _items = [];

  int get itemCount {
    return _items.length;
  }

  List<Book> get items {
    return [..._items];
  }

  List<Book> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Book? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  final BooksService _booksService;
  BooksManager([AuthToken? authToken])
      : _booksService = BooksService(authToken);

  set authToken(AuthToken? authToken) {
    _booksService.authToken = authToken;
  }

  Future<void> fetchBooks() async {
    _items = await _booksService.fetchBooks();
    notifyListeners();
    
  }

  Future<void> fetchUserBooks() async {
    _items = await _booksService.fetchBooks(
      filteredByUser: true,
    );
    notifyListeners();
    
  }

  Future<void> addBook(Book book) async {
    final newBook = await _booksService.addBook(book);
    if (newBook != null) {
      _items.add(newBook);
      notifyListeners();
    }
  }

  Future<void> updateBook(Book book) async {
    final index = _items.indexWhere((item) => item.id == book.id);
    if (index >= 0) {
      if (await _booksService.updateBook(book)) {
        _items[index] = book;
        notifyListeners();
      }
    }
  }

  Future<void> deleteBook(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Book? existingBook = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _booksService.deleteBook(id)) {
      _items.insert(index, existingBook);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Book book) async {
    final saveStatus = book.isFavorite;
    book.isFavorite = !saveStatus;

    if (!await _booksService.saveFavoriteStatus(book)) {
      book.isFavorite = saveStatus;
    }
  }

  Future<void> checkingStock(Book book) async {}
  Future<void> updateStore(Book book) async {}

  // void addBook(Book book) {
  //   _items.add(
  //     book.copyWith(
  //       id: 'p${DateTime.now().toIso8601String()}',
  //     ),
  //   );
  //   notifyListeners();
  // }

  // void updateBook(Book book) {
  //   final index = _items.indexWhere((item) => item.id == book.id);
  //   if (index >= 0) {
  //     _items[index] = book;
  //     notifyListeners();
  //   }
  // }

  // void toggleFavoriteStatus(Book book) {
  //   final saveStatus = book.isFavorite;
  //   book.isFavorite = !saveStatus;
  // }

  // void deleteBook(String id) {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   _items.removeAt(index);
  //   notifyListeners();
  // }
}
