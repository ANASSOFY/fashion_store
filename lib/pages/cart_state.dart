import 'package:fashion_store/pages/product.dart';

class CartState {
  CartState._();

  static final List<ProductModel> _items = [];

  static List<ProductModel> get items => List.unmodifiable(_items);

  static bool contains(ProductModel product) {
    return _items.contains(product);
  }

  static void add(ProductModel product) {
    if (contains(product)) return;
    _items.add(product);
  }

  static void remove(ProductModel product) {
    _items.remove(product);
  }

  static double get totalPrice {
    double total = 0;
    for (final p in _items) {
      total += p.price;
    }
    return total;
  }

  static int get count => _items.length;

  static void clear() {
    _items.clear();
  }
}
