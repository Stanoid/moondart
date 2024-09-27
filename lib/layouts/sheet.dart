import 'package:fltr/models/CartItem.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../models/models.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:fltr/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sheet extends StatefulWidget {
  const Sheet({super.key});

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {

final Widget svgIcon = SvgPicture.asset(
  width: 200,
 'assets/img/void.svg',
  //colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Empty cart illustration'
);

final controller = Get.put(CartController());
bool reb = true;

  void callback() {

    setState(() {
      reb = !reb;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text("My Cart",style: TextStyle(fontSize: 25,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),),

        IconButton(
          
          onPressed: (){ Navigator.pop(context);}, icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        color: Theme.of(context).colorScheme.primary,iconSize: 30,)
      ],),

     Expanded(child: Padding(
       padding: const EdgeInsets.symmetric(vertical: 12),
       child:  ListView(children: 
        controller.getCart().isEmpty?[  Center(child:  Column(
          children: [
            svgIcon,
           Padding(
             padding: const EdgeInsets.only( top:  30),
             child:  Text("Empty Cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
           ),
          ],
        ))]:controller.getCart().entries.map((entry) {
          var w = CartItem(item: entry.value, callback: (){
            callback();
          },);
         // doSomething(entry.key);
          return w;
        }).toList()
         ,),
     )),

   controller.getCart().isEmpty? const SizedBox() :   
    Padding(
      
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text("Total: ${controller.getTotal()} SAR ",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 20,fontWeight: FontWeight.bold), ),
        ElevatedButton(
                                    style:  ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),fixedSize:
                                    const MaterialStatePropertyAll(Size(140, 40)),padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0,horizontal: 20))),
                                    onPressed: (){Navigator.pop(context);}, child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       
                                         Padding(
                                           padding: EdgeInsets.only( right:  5.0),
                                           child: Text("Checkout",style: TextStyle(color: Colors.white,fontSize: 18),),
                                         ),
                                          Icon(Icons.shopping_cart_checkout_sharp,size: 20,color: Colors.white,),
                                      ],
                                    )),
       
      ],),
    )


      ],),
    );
  }
}


class CartItem extends StatefulWidget {
  const CartItem({super.key,
 required this.item,
 required this.callback
  
  });
final CartItemC? item;
final Function callback;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return  Container( margin: const EdgeInsets.only(bottom: 12),
     //padding: const EdgeInsets.all(8),
     clipBehavior: Clip.hardEdge,
     alignment: Alignment.center , width: double.infinity, decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        
        boxShadow: [

          BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 0,
          
          blurRadius: 0,
          
          offset: const Offset(0, 4), // changes position of shadow
        ),]
         ), child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        SizedBox(
          height: 100,
          width: 100,
          child:   Image.network( 'http://192.168.70.110:1337${widget.item?.img}',cacheWidth: 200,fit: BoxFit.cover , alignment: Alignment.topLeft,
    ),
        ),
   Expanded(child: Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text("${widget.item?.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Theme.of(context).colorScheme.primary),),
      ),
     Row(
    
       children: [
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
                children: [
                  Text("Qty: ",style: TextStyle(color: Colors.grey.shade900,fontWeight: FontWeight.bold),),
                  Text("${widget.item?.qty}")
                ],
              ),
                Row(
        children: [
          Text("Price: ",style: TextStyle(color: Colors.grey.shade900,fontWeight: FontWeight.bold),),
          Text("${widget.item?.price} SAR")
        ],
      ),
           ],

         ),

          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                   Container(
          
            margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 3),
              decoration:  BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                 border: Border(
                top: BorderSide( color: Theme.of(context).colorScheme.primary,width: 2),
                left: BorderSide(color: Theme.of(context).colorScheme.primary ,width: 2 ),
                right:BorderSide(color: Theme.of(context).colorScheme.primary,width: 2),
                bottom: BorderSide(color: Theme.of(context).colorScheme.primary,width: 2),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6))
              ),
            child:  Text("${widget.item?.size}",style: 
             const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)
            ,)),
          
             Container( margin: const EdgeInsets.only(right: 4), width: 25,height: 25, decoration: 
                BoxDecoration(color: 
                  HexColor("${widget.item?.color}")
                ,borderRadius: BorderRadius.circular(100), ),  )
          
                   ],))
          
       ],
     ),
    
    ],),
  )),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(  child: IconButton.filled(style: ButtonStyle(iconSize:
          const MaterialStatePropertyAll(20),backgroundColor:
            MaterialStatePropertyAll(Colors.red.shade300)), onPressed: (){ controller.removeFromCart(widget.item!.id!); widget.callback(); }, icon: 
            const Icon(Icons.delete_rounded))),
        ),

      

         ],),);
       
  }
}