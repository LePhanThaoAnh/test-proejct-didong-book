import '../../models/cart_item.dart';
import '../../models/order_item.dart';
import 'package:flutter/foundation.dart';
import '../../services/orders_service.dart';
import '../../models/auth_token.dart';

// class OrdersManager with ChangeNotifier {
//   List<OrderItem> _orders = [
//     // OrderItem(
//     //   id: 'o1',
//     //   amount: 59.98,
//     //   books: [
//     //     CartItem(
//     //       id: 'c1',
//     //       title: 'Red Shirt',
//     //       imageUrl:
//     //           'http://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     //       quantity: 2,
//     //       price: 29.99,
//     //     )
//     //   ],
//     //   dateTime: DateTime.now(),
//     // )
//   ];

//   int get orderCount {
//     return _orders.length;
//   }

//   List<OrderItem> get orders {
//     return [..._orders];
//   }

//   // void addOrder(List<CartItem> cartBooks, double total) async {
//   //   _orders.insert(
//   //     0,
//   //     OrderItem(
//   //       id: 'o${DateTime.now().toIso8601String()}',
//   //       amount: total,
//   //       books: cartBooks,
//   //       dateTime: DateTime.now(),
//   //     ),
//   //   );
//   //   notifyListeners();
//   // }

//   OrderItem? findById(String id) {
//     try {
//       return _orders.firstWhere((item) => item.id == id);
//     } catch (error) {
//       return null;
//     }
//   }

//   final OrderService _ordersService;
//   OrdersManager([AuthToken? authToken])
//       : _ordersService = OrderService(authToken);

//   set authToken(AuthToken? authToken) {
//     _ordersService.authToken = authToken;
//   }

//   Future<void> fetchOrders() async {
//     _orders = await _ordersService.fetchOrders();
//     notifyListeners();
//   }

//   // Future<void> fetchUserOrders() async {
//   //   _orders = await _ordersService.fetchOrders(
//   //     filteredByUser: true,
//   //   );
//   //   notifyListeners();
//   // }

//   Future<void> addOrder(List<CartItem> cartBooks, double total) async {
//     final newOrder = await _ordersService.addOrder(
//       OrderItem(
//         id: 'o${DateTime.now().toIso8601String()}',
//         amount: total,
//         books: cartBooks,
//         dateTime: DateTime.now(),
//       ),
//     );
//     if (newOrder != null) {
//       _orders.add(newOrder);
//       notifyListeners();
//     }
//   }
// }

class OrderManager extends ChangeNotifier {
  List<OrderItem> _orders = [];
  final OrderService _orderService;

  OrderManager([AuthToken? authToken])
      : _orderService = OrderService(authToken);

  set authToken(AuthToken? authToken) {
    _orderService.authToken = authToken;
  }

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    _orders = await _orderService.fetchOrders();

    notifyListeners();
  }

  Future<void> addOrder(OrderItem order) async {
    final newOrder = await _orderService.addOrder(order);

    if (newOrder != null) {
      _orders.add(newOrder);
    }

    notifyListeners();
  }
}
