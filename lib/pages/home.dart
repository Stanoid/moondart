
import 'package:fltr/layouts/ProductHomeGrid.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fltr/comps/search_bar.dart';
import 'package:fltr/layouts/productsList.dart';
//import 'package:fltr/layouts/productsList.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Fltrr'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;

  void _incrementCounter() async {
   
//  final response = await http
//       .get(Uri.parse('http://192.168.91.110:1337/api/products?func=getAllProducts'));
//  //print('data: $response');

// if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//    // print(response.body);
//     log(response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body:   ListView(
        children: [

    Container(
      decoration: BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        
        colors: [Theme.of(context).colorScheme.primary.withAlpha(230),Theme.of(context).colorScheme.inversePrimary,Colors.white])),
      child:  Column(
        children: [
           const Padding(padding: EdgeInsets.symmetric(vertical:  10,horizontal: 6),child: 
          HomeSearchBar()
          ,),

            SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 350.0,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    autoPlay: false,
                    reverse: true,
                    scrollPhysics: const FixedExtentScrollPhysics()),
                items: ["/uploads/offermob6_307369ada7.png","/uploads/offermob2_5ed2735917.png","/uploads/offermob5_7dc65a66b5.png"].map((i) {
                  return Builder(

                    builder: (BuildContext context) {
                      return Container(
                        clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                             
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          child: Image.network(  'http://192.168.70.110:1337$i',cacheWidth: 600,fit: BoxFit.cover , alignment: Alignment.topLeft,
               width: double.infinity)  );
                    },
                  );
                }).toList(),
              ),
            ),
          ),

          
        ],
      ),
    ),



        
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(12.0),
            child:  Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Selected offers",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 25),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text("Our best collection of offers and deals"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  autoPlay: false,
                ),
                items: ["/uploads/ban1_59a67aafdd.png","/uploads/ban2_fb94528d81.png","/uploads/ban3_373172f1b3.png"].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return  Container(
                        clipBehavior: Clip.hardEdge,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          child: Image.network(  'http://192.168.70.110:1337$i',cacheWidth: 600,fit: BoxFit.cover , alignment: Alignment.topLeft,
     width: double.infinity)  );
                    },
                  );
                }).toList(),
              ),
            ),
          ),


   Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child:  Column(
            
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Latest Products", style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 25),),
             const  Padding(
                 padding:  EdgeInsets.symmetric(vertical: 12),
                 child:  Text("Somthing long and formated just to see hoe the text will look like on long paragraph"),
               )
              
              ],),
            ),
           const ProductGrid(),
          ],),
        ),
         



 Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child:  Column(
            
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Latest Products", style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 25),),
           const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child:     Text("Somthing long and formated just to see hoe the text will look like on long paragraph"),
            )
              
              ],),
            ),
      const    ProductsList(),
          ],),
        ),


        const Padding(
          padding:  EdgeInsets.symmetric(vertical: 22),
          child:  Column(
            
            children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Latest Products", style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w900,
                          fontSize: 25),),
                Text("Somthing long and formated just to see hoe the text will look like on long paragraph")
              
              ],),
            ),
            ProductsList(),
          ],),
        ),
         
         
        ],
      ),
     
    );
  }
}



// Future<Album> fetchAlbum() async {
//   final response = await http.get(Uri.parse(
//       'http://192.168.91.110:1337/api/?func=getAllProducts'));
//   log(response.body);
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.

//     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }


// A function that converts a response body into a List<Photo>.
