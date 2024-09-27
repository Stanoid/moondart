import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fltr/comps/product.dart';
//import 'package:fltr/layouts/productsList.dart';
import 'package:flutter/material.dart';
import 'package:fltr/models/models.dart';
//import 'dart:developer';
// app starting point

// class Post {
  
//   int? id;
//   String? name;
//   String? subcat;
//   String? seller;
//   List<String>? img;
//   List<dynamic>? varients;
//   int? price;
//   Post({ this.id,this.name,this.img,this.varients,this.subcat,this.seller});

//   Post.fromJson(Map<String, dynamic> json) {
//    subcat = json['subcatagory']['name_en'];
//   id = json['id'];
//   name = json['name_en'];
// seller = json["seller"]["username"];
  
//   try {

// img = json['img'].replaceAll('[', '')
//                   .replaceAll(']', '').replaceAll('"', '').split(',');

// varients = json['varients'];

//                  // log(varients![0].toString());


//   } catch (e) {
//     log(e.toString());
//   }
  
//   }

  
// }




// homepage class
class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

// homepage state
class _ProductGridState extends State<ProductGrid> {




  // variable to call and store future list of posts
  late final Future<List<Post>>  postsFuture ;

  // function to fetch data from api and return future list of posts
  static Future<List<Post>> getPosts() async {
    var url = Uri.parse("http://192.168.70.110:1337/api/products?func=getAllProducts");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    
    //log(body[0].toString());
    return body.map((e) => Post.fromJson(e)).toList();
  }
  

 @override
  void initState() {
    super.initState();
    postsFuture =  getPosts();
  }






  // build function
  @override
  Widget build(BuildContext context) {

    return  FutureBuilder<List<Post>>(
          future: postsFuture,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Center(child:  SizedBox(height: 50,width: 50,child: CircularProgressIndicator(),)),
              );
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final posts = snapshot.data!;
              
              return buildPosts(posts);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        );
  }

  // function to display fetched data on screen
  Widget buildPosts(List<Post> posts) {
    // ListView Builder to show data in a list

 return  SizedBox(
     //height: 350,
     
      child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 350),
        padding:const EdgeInsets.symmetric(vertical: 8),
       scrollDirection: Axis.vertical,
         itemCount: posts.length,
        
        itemBuilder: (context, index) {
          final post = posts[index];
         
          return  Product(post); 
        },
      ),
    );
  }
    
 
}
