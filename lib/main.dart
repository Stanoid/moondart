//import 'package:flutter/gestures.dart';
//import 'dart:ffi';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fltr/pages/home.dart';
import 'package:fltr/pages/account.dart';
import 'package:fltr/pages/act_login.dart';
import 'package:fltr/pages/orders.dart';
import 'package:fltr/layouts/sheet.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:provider/provider.dart';
import 'models/models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:developer';


class UserController extends GetxController {
 final count = 0.obs;

  void setUsername(int num) {
    count.value = num;
  }
}





class CartController extends GetxController {

  List<CartItemC>? cart;
 

  final box = GetStorage();

  // @override // called when you use Get.put before running app
  // void onInit() {
  //   super.onInit();
  //  // _restoreTheme();
  // }


  Map<dynamic,dynamic> getCart() {
    final cart = box.read('cart') ?? {} ;
   return cart;
  }

  int? getTotal (){
   final cart = box.read('cart') ?? {} ;
   int? total ;
  cart.entries.map((entry) {
       total = (total! + entry.value.price!) as int?;
         log("111111111111 ${entry.value}");
        });
    
   return total;
  }


  void removeFromCart(int id){
var oldcart = box.read('cart') ?? {} ;
oldcart.removeWhere((key, value) => key == id);

log("$oldcart");
box.write('cart', oldcart);
userController.setUsername(oldcart.length);


  }

  void addToCart(CartItemC item,  context,String name) {
    var oldcart = box.read('cart') ?? {} ;
    //final list newCart; 
  oldcart[item.id] = item  ;

  //log("${oldcart.runtimeType}");
  
    box.write('cart', oldcart);
    userController.setUsername(oldcart.length);
     ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

               const Padding(
                 padding:  EdgeInsets.only( right:  6.0),
                 child:  Icon(Icons.check_circle_rounded,color: Colors.white,),
               ),
                Text("${ name.length<=40?name:'${name.substring(0,40)} ...'} added to cart.",style:
                const TextStyle(fontWeight: FontWeight.bold),),
              ],
            )));
   
  }
}

 final userController = Get.put(UserController());
 final controller = Get.put(CartController());

const String assetName = 'assets/img/logowhite-01.svg';
final Widget svgIcon = SvgPicture.asset(
  width: 80,
  assetName,
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Minimoon logo'
);

 void main() async {
  await GetStorage.init();

  runApp( GetMaterialApp(
    theme: ThemeData(
    useMaterial3: true,

    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: HexColor("#e16d64"),
     secondary: HexColor("#65c9e0"),
      brightness: Brightness.light,
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    // textTheme: TextTheme(
    //   displayLarge: const TextStyle(
    //     fontSize: 72,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   // ···
    //   titleLarge: GoogleFonts.oswald(
    //     fontSize: 25,
    //     //fontStyle: FontStyle.italic,
    //   ),
    //   bodyMedium: GoogleFonts.merriweather(),
    //   displaySmall: GoogleFonts.pacifico(),
    // ),
  ),
    debugShowCheckedModeBanner: false,
  
    home: const MyApp(),) );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


int _selectedIndex = 0;
// 8
static List<Widget> pages = <Widget>[
const MyHomePage(title: "fltr"),
const OrdersPage(),
const AccountPage(),

];
// 9
void _onItemTapped(int index) {
 setState(() {
 _selectedIndex = index;
 });
}


// ThemeData _buildTheme(brightness) {
//   var baseTheme = ThemeData(brightness: brightness);

//   return baseTheme.copyWith(
//     textTheme: GoogleFonts.aBeeZeeTextTheme(baseTheme.textTheme),
//   );
// }




  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;


    // void notify (){
    //   ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("data")));
    // };

    return 
      
       Scaffold(
                  drawer:  Drawer(
                  backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                  child: ListView(
                    children:  [
    ListTile(leading: const Icon(Icons.home),
    title: const Text("Home"),
    trailing: Icon(Icons.circle,size: 15,color: Theme.of(context).colorScheme.primary,),
    )
                    ],
                  ),
                ), 
                endDrawer:  Drawer(
                  backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                  child: const Center(child: Text("End Drawer goes here"),),
                ),
                      bottomNavigationBar: BottomNavigationBar(
                items: const  <BottomNavigationBarItem>[
                   BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                   
                     icon:   Icon(Icons.list),
                    label: 'Orders',
                  ),
                   BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_rounded),
                    label: 'Me',
                  ),
                ],
                currentIndex: _selectedIndex,
                // 11
                onTap: _onItemTapped,
                       // currentIndex: 0,
                selectedItemColor: Theme.of(context).primaryColor,
                       
                      ),
                    appBar: AppBar(

                  
               leading: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu,color: Colors.white,),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }
                ),   
                  backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(230),
                  actions: <Widget>[
                 
    
                    Obx(() => 
                     Badge.count(
                        count:userController.count.value,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        offset: const Offset(-3, 4),
                         largeSize: 20,
                         padding:  const EdgeInsets.symmetric( horizontal:  7),
                         textStyle: const TextStyle(fontSize: 15),
                        alignment: Alignment.topLeft, 
                        child:  IconButton(
                      icon: const Icon(Icons.shopping_bag_sharp, color: Colors.white),
                      tooltip: 'Open shopping cart',
                      onPressed: () {
                      showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return  const Sheet();
                    });
                      },
                    ),),
                    ),
                     Builder(
                  builder: (context) {
                    return   IconButton(onPressed: (){
                      Scaffold.of(context).openEndDrawer();
                    }, icon: const Icon(Icons.favorite_rounded,color: Colors.white,));
                  }
                ),   
                
                   
                  ],
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [              
                      Row(
                       
                        children: [
                        svgIcon,
                        // const SizedBox(
                        //     child: Center(
                        //         child: Padding(
                        //             padding: EdgeInsets.all(5),
                        //             child: Text(
                        //               "Minimoon",
                        //               style: TextStyle(
                        //                   color: Color.fromRGBO(255, 255, 255, 1)),
                        //             ))))
                      ]),
                       Row(children: [
                      Hero(tag: "login_tag", child:  ElevatedButton(
                         
                        style:  const ButtonStyle(elevation: MaterialStatePropertyAll(0),backgroundColor:MaterialStatePropertyAll(Colors.transparent),padding:
                         MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0,horizontal: 20))),
                        onPressed: (){Get.to(const LoginPage());}, child:  const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           
                             Padding(
                               padding: EdgeInsets.only( right:  5.0),
                               child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                             ),
                              Icon(Icons.login,size: 15,color: Colors.white,),
                          ],
                        )))
                      ],)
                    ],
                  )),
                      body:   pages[_selectedIndex],
                      floatingActionButton: Obx(() => Badge.count(
                        count:userController.count.value,
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        offset: const Offset(-3, -3),
                         largeSize: 20,
                         padding:  const EdgeInsets.symmetric( horizontal:  7),
                         textStyle: const TextStyle(fontSize: 15),
                        alignment: Alignment.topLeft, 
                        child: FloatingActionButton(
                 onPressed: () {
                      
                 showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return  const Sheet();
                    });


               // userController.setUsername(5);

              // controller.savename("yo!!");
                
                },
                tooltip: 'Increment',
                child: Icon(
                  size: 25,
                  Icons.shopping_bag_outlined,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
                      ),)) // This trailing comma makes auto-formatting nicer for build methods.
                    );
      
  }
}




class MenueItem extends StatefulWidget {
  const MenueItem({super.key});

  @override
  State<MenueItem> createState() => _MenueItemState();
}

class _MenueItemState extends State<MenueItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}