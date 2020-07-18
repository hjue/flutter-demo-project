import 'package:dio/dio.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/helpers/constants.dart';

class API {
  static const endpoint = URL.ProductList;

  var client = Dio();

  Future<List<Product>> getProducts() async {
    var products = List<Product>();

    var response = await client.get('$endpoint');

    if (response.data != null) {
      var data = response.data['data']['products'] as List<dynamic>;

      for (var product in data) {
        products.add(Product.fromJson(product));
      }
    }

    return products;
  }
}
