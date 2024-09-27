import 'dart:convert';
import 'package:fltr/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';
import 'package:fltr/comps/product_selector.dart';
import 'package:fltr/layouts/sheet.dart';
import 'package:fltr/models/models.dart';
import 'dart:developer';
// app starting point

class Product {
  
  int? id;
  String? name;
  String? desc;
  List<String>? img;
  String? subcat;
  String? cat;
  List<dynamic>? varients;
  int? price;
  Product({this.cat, this.id,this.subcat,this.name,this.img,this.varients,this.desc});

  Product.fromJson(Map<String, dynamic> json) {
   
  id = json['data']['id'];
  desc = json['data']['attributes']['description_en'];
  name = json['data']['attributes']['name_en'];
  subcat = json['data']['attributes']['subcatagory']['data']['attributes']['name_en'];
  cat = json['data']['attributes']['subcatagory']['data']['attributes']['catagory']['data']['attributes']['name_en'];
  
  try {

img = json['data']['attributes']['img'].replaceAll('[', '')
                  .replaceAll(']', '').replaceAll('"', '').split(',');

varients = json['data']['attributes']['varients']['data'];

                 // log(varients![0].toString());


  } catch (e) {
 //   log(e.toString());
  }
  
  }

  
}




// homepage class
class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key,this.id});
final int? id;
  @override
  State<ProductDetails> createState() => _ProductsListState();
}

// homepage state
class _ProductsListState extends State<ProductDetails> {




  // variable to call and store future list of posts
  late final Future<Product>  postsFuture ;
late final int? pid;
  // function to fetch data from api and return future list of posts
  static Future<Product> getPosts(int? pid) async {
    var url = Uri.parse("http://192.168.70.110:1337/api/products/$pid?func=getFullProduct");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String,dynamic> body = json.decode(response.body);
    
   
    return  Product.fromJson(body);
  }
  

 @override
  void initState() {
    super.initState();
    pid = widget.id;
    postsFuture =  getPosts(pid);
    
  }

  final userController = Get.put(UserController());
  final controller = Get.put(CartController());
 

  // build function
  @override
  Widget build(BuildContext context) {

    return  FutureBuilder<Product>(
          future: postsFuture,
          builder: (context, snapshot) {
  //  log("ssssssssssssssssssssssssssssss${snapshot.data!.varients}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const Scaffold(body: Center(child:  SizedBox(height: 100,width: 100,child: Column(children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only( top:  16.0),
                  child: Hero(tag: "lod", child: Text("Loading...")),
                )
              ],))),);
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final posts = snapshot.data!;
              
              return buildPosts(posts,context);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        );
  }

  // function to display fetched data on screen
  Widget buildPosts(Product posts, BuildContext context) {
    // ListView Builder to show data in a list
    
    return  Scaffold(
      
      appBar: AppBar(
        actions: [IconButton( onPressed: ()=>{
          log("${controller.getCart()}")
        },
          icon: Icon(Icons.bookmark_add_outlined,color: Theme.of(context).colorScheme.primary,)),
         Obx(() =>   Badge.count(
                        count:userController.count.value,
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        offset: const Offset(-2, 4),
                         largeSize: 20,
                         padding:  const EdgeInsets.symmetric( horizontal:  7),
                         textStyle: const TextStyle(fontSize: 15),
                        alignment: Alignment.topLeft, 
                        child:   IconButton( 
                          onPressed: () {
                      showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return  const Sheet();
                    });
                      },
          icon: Icon(Icons.shopping_bag_outlined,color: Theme.of(context).colorScheme.primary,)),),),
           IconButton( 
             onPressed: () {
                   
                      },
          icon: Icon(Icons.favorite_border_outlined,color: Colors.red.shade600,))
          ],
          title: Text('${posts.name}'),
      ),
       floatingActionButton: FloatingActionButton.extended(
         onPressed: () {
          controller.addToCart(CartItemC(id: posts.id, name: posts.name, color: posts.varients![0]['attributes']['color']['data']['attributes']['colorCode'], img: posts.img![0], 
          qty: 1, size: posts.varients![0]['attributes']['size']['data']['attributes']['icon'], 
          price: posts.varients![0]['attributes']['price'].toString()),context,posts.name!);
         
        },
        label: const Text("Add to cart"),
        tooltip: 'Add to Cart',
        icon: Icon(
          Icons.add_shopping_cart_outlined,
          color: Theme.of(context).primaryColor,
        ),
              ),
      body: ListView(
      children: [
    //         SizedBox( width: double.infinity,
    // child: Image.network( 'http:// 192.168.70.110:1337${posts.img![0]}',cacheWidth: 600,fit: BoxFit.cover , alignment: Alignment.topLeft,
    // width: double.infinity) ),

 SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 350.0,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    autoPlay: false,
                    reverse: true,
                    scrollPhysics: const FixedExtentScrollPhysics()),
                items: posts.img!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          child: 
     WidgetZoom(
    heroAnimationTag: i,
    zoomWidget: Image.network(
        'http://192.168.70.110:1337$i',cacheWidth: 600,fit: BoxFit.cover , alignment: Alignment.topLeft,
         width: double.infinity
    ),
),
       );
                    },
                  );
                }).toList(),
              ),
            ),
          ),

          Padding(padding: const EdgeInsets.symmetric( vertical:  16,horizontal: 10), child: Row(children: [
            Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
         color: Theme.of(context).primaryColor
       ), child: Text(posts.cat.toString(),style: const TextStyle(color: Colors.white),)),
     Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        margin: const EdgeInsets.only(left: 8),
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
         color: Theme.of(context).colorScheme.inversePrimary
       ), child: Text(posts.subcat.toString(),style: const TextStyle(color: Colors.white),))

          ],), ),

     Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),child:
      Column(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(  children: [
        Expanded( flex:8, child:  Container( decoration: const BoxDecoration(color: Colors.white),
        child: Text('${posts.name}',style:const TextStyle(fontSize: 25),),
        )),
      
          Expanded( flex:4, child:  Container( alignment: Alignment.centerRight, decoration: const BoxDecoration(color: Colors.white),
          child:  Stack(  alignment: Alignment.bottomLeft, children: [
            Text('${posts.varients![0]['attributes']['price']} SAR',style:  TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
           // Text('450 Sar',style:  TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
          ],)
          ))
      ],),
    ),




    Padding(
     padding:  const EdgeInsets.all(8.0),
     child:  Row(children: [
        Expanded( flex:1, child: ProductSelector(varients: posts.varients,)),
          
      ],),
   ),



        Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column( 
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Padding(
          padding:  EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Product description: ",style: TextStyle(fontSize: 20),),
        ),
        Text('${posts.desc}',style:  TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.grey.shade600,letterSpacing: 0.3,wordSpacing: 3),),
      ] 
      
      ),
    ),
   

       const Padding(
        padding:  EdgeInsets.all(8.0),
        child: ExpansionTileExample()
      ),
     

      ],)
     )

      ],
    ),);
  }
}



class ExpansionTileExample extends StatefulWidget {
  const ExpansionTileExample({super.key});

  @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}

class _ExpansionTileExampleState extends State<ExpansionTileExample> {
 // bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
      
      ExpandUnits(
        title:  Text("Product Specification: ",style: TextStyle(fontSize: 20),),
        icon:  Icon(Icons.table_chart, size: 25,color: Colors.white,),
        subtitle: Text('Material and manufacturing information'),
        content: Text('This is tile number 1'),
      ),


        ExpandUnits(
        title:  Text("Delivery: ",style: TextStyle(fontSize: 20),),
        icon:  Icon(Icons.delivery_dining_sharp, size: 25,color: Colors.white,),
        subtitle: Text('Shipping and Delivery information'),
        content: Text('This is tile number 1'),
      ),

        ExpandUnits(
        title:  Text("Ratings and reviews: ",style: TextStyle(fontSize: 20),),
        icon:  Icon(Icons.stars_sharp, size: 25,color: Colors.white,),
        subtitle: Text('Purchasing custumers rating and reviews'),
        content: Text('This is tile number 1'),
      ),
    
       
        
       SizedBox(height: 65,)

      ],
    );
  }}

  class ExpandUnits extends StatefulWidget {
  const ExpandUnits({super.key, required this.icon,required this.subtitle,required this.content,required this.title});

final Widget? icon,title,subtitle,content;


  @override
  State<ExpandUnits> createState() => _ExpandUnitsState();
}

class _ExpandUnitsState extends State<ExpandUnits> {

  @override
  Widget build(BuildContext context) {
    return   ExpansionTile(
          title: Row(
            
            children: [
            Padding(
              padding: const EdgeInsets.only( right: 10,bottom: 10),
              child: Container( 
                padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: widget.icon!),
            ),

             widget.title!
        
          ],),
          subtitle: widget.subtitle!,
          children:  <Widget>[
            ListTile(title: widget.content),
          ],
        )
;
  }
}
