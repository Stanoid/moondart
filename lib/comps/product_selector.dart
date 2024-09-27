import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:developer';
class ProductSelector extends StatefulWidget {
  const ProductSelector({super.key,required this.varients});
final List<dynamic>? varients;
  @override
  State<ProductSelector> createState() => _ProductSelectorState();
}

List<dynamic>? vars;

class _ProductSelectorState extends State<ProductSelector> {



@override
void initState(){
  super.initState();
  
vars = widget.varients?.toList();
//log("aaaaaaaaaaaaaaaaaaaaaaa$vars");
}




  @override
  Widget build(BuildContext context) {

  
  log(" from build $vars");

List<Widget> sizesWidgets = vars!.map((vari) {

return  Container(
  margin: const EdgeInsets.only(right: 4),
    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
    decoration:  BoxDecoration(
       border: Border(
      top: BorderSide( color: Theme.of(context).colorScheme.primary,width: 2),
      left: BorderSide(color: Theme.of(context).colorScheme.primary ,width: 2 ),
      right:BorderSide(color: Theme.of(context).colorScheme.primary,width: 2),
      bottom: BorderSide(color: Theme.of(context).colorScheme.primary,width: 2),
    ),
    borderRadius: const BorderRadius.all(Radius.circular(6))
    ),
  child: Text("${vari['attributes']['size']['data']['attributes']['icon']}",style: 
  const TextStyle(fontSize: 17,fontWeight: FontWeight.bold)
  ,));
    
  
    }).toList();

    List<Widget> Colorswidgets = vars!.map((vari) {

return Container( margin: const EdgeInsets.only(right: 4), width: 40,height: 40, decoration: 
      BoxDecoration(color: 
        HexColor(vari['attributes']['color']['data']['attributes']['colorCode'])
      ,borderRadius: BorderRadius.circular(100), ),  );
    
  
    }).toList();




    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white, 
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 4), // changes position of shadow
        ),
      ]),
      child:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(
                     
                      child: Align( alignment: Alignment.centerLeft, child: Text("Sizes: ",style: 
                      TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.grey.shade700),),),
                    )),
                Expanded(
                    flex: 2,
                    child: SizedBox(
                    
                      child: Center(child: Row(children: 
                                           sizesWidgets
                                          ,),),
                    ))
              ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric( vertical: 8.0),
              child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(
                     
                      child: Align( alignment: Alignment.centerLeft, child: Text("Colors: ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.grey.shade700),),),
                    )),
                Expanded(
                    flex: 2,
                    child: SizedBox(
                    
                      child: Center(child: Row(children: 
                                           Colorswidgets
                                          ,),),
                    ))
              ],
                        ),
            ),
          
      //  Align( alignment: Alignment.centerRight, child:   Padding(
      //      padding: const EdgeInsets.only(top: 8.0),
      //      child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.add_shopping_cart_outlined), label: Text("Add to cart")),
      //    ),)
        ],
      ),
    );
  }
}
