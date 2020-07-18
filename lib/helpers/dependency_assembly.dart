import 'package:get_it/get_it.dart';
import 'package:shopnbuy/core/services/api.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/core/viewmodels/product_list_model.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => API());
  getIt.registerFactory(() => ProductListModel());
  getIt.registerFactory(() => CartModel());
}
