// To parse this JSON data, do
//
//     final productModelApi = productModelApiFromJson(jsonString);

import 'dart:convert';

ProductModelApi productModelApiFromJson(String str) => ProductModelApi.fromJson(json.decode(str));

class ProductModelApi {
    List<Product> products;

    ProductModelApi({
        required this.products,
    });

    factory ProductModelApi.fromJson(Map<String, dynamic> json) => ProductModelApi(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    
}

class Product {
    int id;
    String title;
   
    double price;
    
    List<String> images;
    String thumbnail;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.images,
        required this.thumbnail,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        
        price: json["price"]?.toDouble(),
      
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
    );

   
}

