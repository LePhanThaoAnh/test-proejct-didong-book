import '../../models/product.dart';

class ProductsManager {
  final List<Product> _items = [];
  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favortiteItems {
    return _items.where((item) => item.isFavorite).toList();
  }
}
