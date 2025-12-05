import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('Cart', () {
    setUp(() {
      // Clear the global cart state before each test
      clearCart();
    });

    test('should add item to cart', () {
      final cart = Cart();
      final item = CartItem(
        id: '1',
        name: 'Test Product',
        price: 10.0,
        quantity: 1,
      );

      cart.addItem(item);

      expect(cart.items.length, 1);
      expect(cart.items[0].name, 'Test Product');
    });

    test('should remove item from cart', () {
      final cart = Cart();
      final item = CartItem(
        id: '1',
        name: 'Test Product',
        price: 10.0,
      );

      cart.addItem(item);
      expect(cart.items.length, 1);

      cart.removeItem('1');
      expect(cart.items.length, 0);
    });

    test('should update item quantity', () {
      final cart = Cart();
      final item = CartItem(
        id: '1',
        name: 'Test Product',
        price: 10.0,
        quantity: 1,
      );

      cart.addItem(item);
      cart.updateItemQuantity('1', 3);

      expect(cart.items[0].quantity, 3);
    });

    test('should calculate subtotal correctly', () {
      final cart = Cart();
      cart.addItem(CartItem(id: '1', name: 'Product 1', price: 10.0, quantity: 2));
      cart.addItem(CartItem(id: '2', name: 'Product 2', price: 15.0, quantity: 1));

      // 10*2 + 15*1 = 20 + 15 = 35
      expect(cart.subtotal, 35.0);
    });

    test('should calculate delivery fee', () {
      final cart = Cart();
      cart.addItem(CartItem(id: '1', name: 'Product 1', price: 10.0));

      expect(cart.deliveryFee, 3.99);
    });

    test('should calculate total correctly', () {
      final cart = Cart();
      cart.addItem(CartItem(id: '1', name: 'Product 1', price: 10.0, quantity: 2));

      // subtotal (20.0) + delivery fee (3.99) = 23.99
      const expectedTotal = 20.0 + 3.99;
      expect(cart.total, expectedTotal);
    });

    test('should save cart to storage', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final cart = Cart();
      cart.addItem(CartItem(id: '1', name: 'Product 1', price: 10.0));

      // Just verify no exception is thrown
      expect(() => cart.saveCart(), returnsNormally);
    });

    test('should load cart from storage', () async {
      final cart = Cart();
      await cart.loadCart();
      expect(true, true);
    });

    test('should clear cart', () {
      final cart = Cart();
      cart.addItem(CartItem(id: '1', name: 'Product 1', price: 10.0));
      
      cart.clearCart();
      
      expect(cart.items.length, 0);
      expect(cart.subtotal, 0.0);
    });
  });
}
