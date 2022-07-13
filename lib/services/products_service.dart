import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = 'etsy-uy-default-rtdb.firebaseio.com';

  final List <Product> products = [];

  late Product selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService(){
    loadProducts();
  }

  Future <List<Product>> loadProducts() async {
  isLoading = true;
  notifyListeners();
  final url = Uri.https(_baseUrl, 'products.json');
  final resp = await http.get(url);

  final Map<String, dynamic> productsMap = json.decode(resp.body);
      productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);

  });

  isLoading = false;
  notifyListeners();

  return products;
  }

  Future saveOrCreateProduct (Product product) async {
    isSaving = true;
    notifyListeners();

  if (product.id == null) {
    await createProduct(product);
  } else {
    await upDateProduct(product);
  }


    isSaving = true;
    notifyListeners();
  }

  Future<String> upDateProduct (Product product) async {
      final url = Uri.https(_baseUrl, 'products/${product.id}.json');
      final resp = await http.put(url, body: product.toJson());
      final decodeData = resp.body;

      print(decodeData);

      final index = products.indexWhere((element) => element.id == product.id);
      products[index] = product;
      return product.id!;
  }

    Future<String> createProduct (Product product) async {
      final url = Uri.https(_baseUrl, 'products.json');
      final resp = await http.post(url, body: product.toJson());
      final decodeData = json.decode(resp.body);

      product.id = decodeData['name'];

      products.add(product);

      return product.id!;
  }
}