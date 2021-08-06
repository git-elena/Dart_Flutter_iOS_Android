
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class PageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: FutureBuilder<List<Product>>(
          future: fetchProduct(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return const Center(
                child: Text("error !!!"),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    //minHeight: 500,
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        //color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: ProductsList(products: snapshot.data!)
                      ),
                      //SizedBox(height: 10,),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }


}

Future<List<Product>> fetchProduct(http.Client client) async {
  final response = await client
  .get(Uri.parse('https://www.hirosaki.store/wp-json/wc/v1/products?per_page=10&offset=1&consumer_key=ck_82e7d8baebb8499987fb34f8caba6e7f8f59d908&consumer_secret=cs_3a58342c5c5a39bd07e0a2a67a61691c81d1ed5a'));

  return compute(parseProduct, response.body);
}

List<Product> parseProduct(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

// List<Categories> parseCategory(String json) {
//   final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
//   return parsed.map<Categories>((json) => Categories.fromJson(json)).toList();
// }

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



class Product {
  final int id;
  final String photoSrc;
  final String name;
  final String price;
  final String weight;
  final String description;
  final List<Categories> categories;

  listCategories() {
    String list = "";
    for(var item in categories) {
      list = list + (list.isEmpty?"":"\n") + item.name;
    }
    return list;
  }

  const Product({
    required this.id,
    required this.name,
    required this.photoSrc,
    required this.price,
    required this.weight,
    required this.description,
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {

    final List<Categories> list = [];

    for (var item in json['categories']) {
      list.add(Categories(id: item['id'], name: item['name']));
    }

    return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        photoSrc: json['images'][0]['src'].replaceFirst('.jpg', '-300x300.jpg')  as String,
        price: json['price'] as String,
        weight: json['weight'] as String,
        description: json['description'] as String,
      // compute(parseProduct, response.body);
      categories: list,
        //Category.fromJson(json['categories'][0]),
        //Category.fromJson(json['categories'][1]),
      //]
    );
  }
}

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build (BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
        ),
        itemCount: products.length,
      itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            height: 450,
            child: Stack (
              children: [
                Column(
                //mainAxisSize: MainAxisSize.values[0],

                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    //margin: const EdgeInsets.only(top: 10),
                    color: Colors.grey,
                    height: 1,
                    child: null,//SizedBox(height: 2, width: MediaQuery.of(context).size.height,),
                  ),

                  Image.network(products[index].photoSrc),

                  Text(products[index].name,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(products[index].price,
                      style: const TextStyle(
                        //height: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),

                      ),
                      Text(" грн / " + products[index].weight + " г"),
                    ],
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('У кошик'),
                  ),


                ],
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(products[index].description.replaceAll("<p>", "").replaceAll("</p>", "").replaceAll(",",   "\n")),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(products[index].listCategories()),
                          //products[index].categories,)
                  ),
                ),
              ]
            ),
          );
      },
    );
  }

}

