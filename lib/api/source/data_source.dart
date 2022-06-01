import 'base_network.dart';
import 'package:prak_b_123190086_123190093/api/model/products_model.dart';

class DataSource {
  static DataSource instance = DataSource();

  Future<List<ProductsModel>> loadMakeup() {
    return BaseNetwork.getMakeup("");
  }

  Future<List<ProductsModel>> loadMakeupByBrand(String brand) {
    return BaseNetwork.getMakeup("?brand="+brand);
  }

  Future<List<ProductsModel>> loadMakeupByProductType(String type) {
    return BaseNetwork.getMakeup("?product_type="+type);
  }
}