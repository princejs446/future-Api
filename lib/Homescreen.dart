import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_api_example/detailpage.dart';
import 'package:future_api_example/product_model.dart';
import 'package:http/http.dart' as http;


class Homescreen  extends StatefulWidget{
  const Homescreen({super.key});
  
  @override  
  State<Homescreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<Homescreen>{
  bool _isLoading=true;

  @override  
  void initState(){
    super.initState();
   
  }
  ProductModelApi?dataFormAPI;

  Future<ProductModelApi?>getData()async{
    try{
      String url="https://dummyjson.com/products";
      http.Response res =await http.get(Uri.parse(url));
      if(res.statusCode==200){
        dataFormAPI=ProductModelApi.fromJson(json.decode(res.body));
        return dataFormAPI;
        _isLoading=false;
        setState(() {
          
        });
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }
  @override  
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Example",
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<ProductModelApi?>(
        future: getData(),
        builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if (snapshot.hasError){
            return Text('Error:${snapshot.error}');
          }else if (snapshot.hasData){
return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        ),
        itemCount: dataFormAPI!.products.length,
         itemBuilder: (context,index){
          final product = dataFormAPI!.products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
               MaterialPageRoute(builder: (BuildContext context)=>
               ProductDetailPage(
                product:product,
               )));
            },
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black,
                width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 0,
                    spreadRadius: 1,
                  )
                ]
              ),
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(product.thumbnail,
                  width: 100,height: 100),
                  SizedBox(height: 10),
                  Text(product.title),
                  SizedBox(height: 5),
                  Row(children: [
                    Text("\$${product.price.toString()}"),
                  ],
                  )
                ],
              ),
            ),
          );
         },
         );
         
          }
          else {
            return Text('No data Found');        
              }
        },
      )
      
    );
  }
  }