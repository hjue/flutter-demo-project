import 'package:flutter_test/flutter_test.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/helpers/dependency_assembly.dart';

List<Product> mockProducts = [
  Product(id: 1, name: "Product1", price: 111, imageUrl: "imageUrl"),
  Product(id: 2, name: "Product2", price: 222, imageUrl: "imageUrl"),
  Product(id: 3, name: "Product3", price: 333, imageUrl: "imageUrl"),
  Product(id: 4, name: "Product4", price: 444, imageUrl: "imageUrl"),
];

void main() {
  setupDependencyAssembler();

  var cartViewModel = dependencyAssembler<CartModel>();

  cartViewModel.addToCart(mockProducts[0]);
  cartViewModel.addToCart(mockProducts[1]);
  cartViewModel.addToCart(mockProducts[2]);
  cartViewModel.addToCart(mockProducts[3]);
  cartViewModel.addToCart(mockProducts[0]);
  cartViewModel.addToCart(mockProducts[1]);

  group('Given Cart Page Loads', () {
    test('Page should load list of products added to cart', () async {
      expect(cartViewModel.cartSize, 6);
      expect(cartViewModel.getCartSummary().keys.length, 4);
    });

    test(
        'Page should consolidate products in cart and show accurate summary data',
        () {
      cartViewModel.getCartSummary();
      expect(cartViewModel.getProduct(0).id, 1);
      expect(cartViewModel.getProduct(1).id, 2);
      expect(cartViewModel.getProduct(2).id, 3);
      expect(cartViewModel.getProduct(3).id, 4);

      expect(cartViewModel.getProductQuantity(0), 2);
      expect(cartViewModel.getProductQuantity(1), 2);
      expect(cartViewModel.getProductQuantity(2), 1);
      expect(cartViewModel.getProductQuantity(3), 1);
    });

    test('When user confirms the purchase, it should show total costs', () {
      expect(cartViewModel.totalCost, 1443);
    });

    test('When user has finished the purchase, it should clear the cart', () {
      cartViewModel.clearCart();
      expect(cartViewModel.cartSize, 0);
    });
  });
}
