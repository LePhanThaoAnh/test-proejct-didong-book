import 'cart_item.dart';

class OrderItem {
  final String? id; //id=null
  final int amount;
  final List<CartItem> books;
  final DateTime dateTime;

  int get bookCount {
    return books.length;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.books,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith(
      {String? id, int? amount, List<CartItem>? books, DateTime? dateTime}) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      books: books ?? this.books,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'books': books,
      'dateTime': dateTime,
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      books: json['books'],
      dateTime: json['dateTime'],
    );
  }
}
