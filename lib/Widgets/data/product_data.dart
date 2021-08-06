/*
* HIROSAKI Products Data
* by Wolf
*/

import 'dart:convert';

List<Categories> parseCategories(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
}

class Categories {
  final int id;
  final String name;

  const Categories({
    required this.id,
    required this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

// help class to return state about empty loading
class ResultLoading {
  final List<Product> listProduct;
  final bool isEmptyLoad;
  const ResultLoading ({
      required this.listProduct,
      required this.isEmptyLoad,
  });
}

ResultLoading parseProduct(String responseBody, int category) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  final List<Product> list = parsed.map<Product>((json) => Product.fromJson(json)).toList();
  if(list.isEmpty) {
    ResultLoading(listProduct: [], isEmptyLoad: true);
  }
  if(category == 0) {
    return ResultLoading(listProduct: list, isEmptyLoad: false);
  }
  List<Product> resultList = [];
  for(Product item in list) {
    for(Categories itemId in item.categories) {
      if(itemId.id == category) {
        resultList.add(item);
      }
    }
  }
  return ResultLoading(listProduct: resultList, isEmptyLoad: false);
}

class Product {
  final int id;
  final String photoSrc;
  final String name;
  final String price;
  final String weight;
  final String description;
  //final String categories;
  final List<Categories>  categories;

  const Product({
    required this.id,
    required this.name,
    required this.photoSrc,
    required this.price,
    required this.weight,
    required this.description,
    required this.categories,
  });

  bool isCategory(int id){

    return false;
  }

  factory Product.fromJson(Map<String, dynamic> json) {

    final List<Categories> list = [];

    for (var item in json['categories']) {
      list.add(Categories(id: item['id'], name: item['name']));
    }

    final String photoSrc = (json['images'] as List<dynamic>).isEmpty?"":json['images'][0]['src'].replaceFirst('.jpg', '-300x300.jpg');

    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      photoSrc: photoSrc,
      price: json['price'] as String,
      weight: json['weight'] as String,
      description: json['description'] as String,
      categories: list,
    );
  }
}
