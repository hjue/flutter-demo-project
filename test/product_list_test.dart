import 'package:flutter_test/flutter_test.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/core/services/api.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/core/viewmodels/product_list_model.dart';
import 'package:shopnbuy/helpers/dependency_assembly.dart';

class MockAPI extends API {
  @override
  Future<List<Product>> getProducts() {
    return Future.value([
      Product(
          id: 1,
          name: "MacBook Pro 16-inch model",
          price: 2399,
          imageUrl: "imageUrl"),
      Product(id: 2, name: "AirPods Pro", price: 249, imageUrl: "imageUrl"),
    ]);
  }
}

final Product mockProduct =
    Product(id: 1, name: "Product1", price: 111, imageUrl: "imageUrl");

void main() {
  setupDependencyAssembler();
  var productListViewModel = dependencyAssembler<ProductListModel>();
  productListViewModel.api = MockAPI();

  var cartViewModel = dependencyAssembler<CartModel>();

  group('Given Product List Page Loads', () {
    test('Page should load a list of products from firebase', () async {
      await productListViewModel.getProducts();
      expect(productListViewModel.products.length, 2);
      expect(
          productListViewModel.products[0].name, 'MacBook Pro 16-inch model');
      expect(productListViewModel.products[0].price, 2399);
      expect(productListViewModel.products[1].name, 'AirPods Pro');
      expect(productListViewModel.products[1].price, 249);
    });
  });

  test('when user adds a product to cart, badge counter should increment by 1',
      () {
    cartViewModel.addToCart(mockProduct);

    expect((cartViewModel.cartSize), 1);
  });
}
