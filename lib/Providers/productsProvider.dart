import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shocase/Models/httpException.dart';
import 'package:shocase/Providers/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  final String authToken;
  final String userId;

  ProductsProvider(this.authToken, this.userId, this._items);

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

// FETCHING ADDED PRODUCT FROM SERVER
  Future<void> addFetchSetProducts([bool filterByUser = false]) async {
    final Map<String, dynamic> urlMap= { "auth" : authToken};
    final filterString = filterByUser ? { urlMap["orderBy"] = "\"creatorId\"", urlMap["equalTo"] = "\"$userId\"" } : "";
    var url = Uri.https('shocasedb-default-rtdb.firebaseio.com', '/products.json', urlMap);
    print("URL : " + url.toString());
    // var url = Uri.https('shocasedb-default-rtdb.firebaseio.com', '/products.json', { "auth" : authToken, "orderBy" : "\"creatorId\"", "equalTo": "\"$userId\"" });
    // try {
      final response = await http.get(url);
      // final extractedData = json.decode(response.body.toString()) as Map<String, dynamic>;
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null){
        return;
      }
      url = Uri.https(
          'shocasedb-default-rtdb.firebaseio.com', '/userFavorites/$userId.json',{ "auth" : authToken });
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    // } catch (error) {
    //   throw (error);
    // }
  }

// ADD PRODUCT
  Future<void> addProduct(Product product) async {
    final url =
    Uri.https('shocasedb-default-rtdb.firebaseio.com', '/products.json', { "auth" : authToken });
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId' : userId,
        }),
      );
      // .then((response) {
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct);
      notifyListeners();
      // }).catchError((error){
      //   throw error;
      // });
    } catch (error) {
      throw error;
    }
  }

//UPDATE PRODUCT
  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      final url = Uri.https(
          'shocasedb-default-rtdb.firebaseio.com', '/products/$id.json',{ "auth" : authToken });
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('......');
    }
  }

//DELETE PRODUCT
  Future<void> deleteProduct(String id) async {
    final url = Uri.https(
        'shocasedb-default-rtdb.firebaseio.com', '/products/$id.json',{ "auth" : authToken });
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could not Delete Product Please try Again later');
      }
      existingProduct = null!;

  }
}
