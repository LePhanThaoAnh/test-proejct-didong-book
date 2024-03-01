import 'package:flutter/material.dart';
import 'package:myshop/ui/cart/cart_screen.dart';
import 'package:myshop/ui/orders/orders_screen.dart';
import 'ui/products/products_manager.dart';
import 'ui/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.purple,
      secondary: Colors.deepOrange,
      background: Colors.white,
      surfaceTint: Colors.grey[200],
    );
    final themData = ThemeData(
      fontFamily: 'Lato',
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shadowColor: colorScheme.shadow,
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 20,
        ),
      ),
    );
    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: themData,
      // home: const SafeArea(
      //   child: CartScreen(),
      // ),
      home: const ProductsOverviewScreen(),
      // child: ProductDetailScreen(ProductsManager().items[0]),
      // child: ProductsOverviewScreen(),
      // child: UserProductsScreen(),
      // child: CartScreen(),
      // Thuộc tính routes thường dùng khai báo
      // các route không tham số.

      routes: {
        CartScreen.routeName: (ctx) => const SafeArea(
              child: CartScreen(),
            ),
        OrderScreen.routeName: (ctx) => const SafeArea(
              child: OrderScreen(),
            ),
        UserProductsScreen.routeName: (ctx) => const SafeArea(
              child: UserProductsScreen(),
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ProductDetailScreen.routeName) {
          final productId = settings.arguments as String;
          return MaterialPageRoute(
            settings: settings,
            builder: (ctx) {
              return SafeArea(
                child: ProductDetailScreen(
                  ProductsManager().findById(productId)!,
                ),
              );
            },
          );
        }
        return null;
      },
    );
  }
}
