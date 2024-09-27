import 'package:fltr/pages/login.dart';
import 'package:flutter/material.dart';
//import 'dart:developer';
import 'package:fltr/models/models.dart';
import 'package:hexcolor/hexcolor.dart';
class Product extends StatelessWidget {
  const Product(this.data, {super.key});

final Post  data;




  @override
  Widget build(BuildContext context) {


List<Widget> taskWidgets = data.varients!.map((task) {
//log(task.toString());


      return  Container( margin: const EdgeInsets.only(right: 4), width: 20,height: 20, decoration: 
      BoxDecoration(color: 
        HexColor(task['color']['colorCode'])
      ,borderRadius: BorderRadius.circular(100), ),  );
    }).toList();



  return Container
(
  

    height: double.infinity,
    
    
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.all(6),
    decoration:  BoxDecoration(
      boxShadow: [
        BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 4), // changes position of shadow
      ),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      
      
      color: Colors.white,
    ),
    child: InkWell(
    splashColor: Theme.of(context).colorScheme.primary.withAlpha(30),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetails(id: data.id)
       , settings: RouteSettings(
              arguments: data.id,
            ),));
    },
    child: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    
    Stack( 
  
    children: <Widget>[
      SizedBox(

        height: 200,
        child: Image.network( 'http://192.168.70.110:1337${data.img![0]}',cacheWidth: 250,fit: BoxFit.cover , alignment: Alignment.topLeft,
    width: double.infinity) ,
      ),
    
     Positioned( top: 0,right: 0, child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Icon(Icons.favorite,color: Colors.red.shade400.withAlpha(150),),
     )),
       Positioned( bottom: 0,left: 0, child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
        
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
         color: Theme.of(context).primaryColor.withAlpha(150)
       ), child: Text(data.subcat.toString(),style: const TextStyle(color: Colors.white),))
     )),


        ]),


    
   Expanded(child: 
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

 Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text('${ data.name!.length<=40?data.name!:'${data.name!.substring(0,40)} ...' }  '),
  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(data.seller.toString(),style: const TextStyle(color: Colors.grey),),
       Padding(
         padding: const EdgeInsets.only(left: 2),
         child: Icon(Icons.verified,size: 15,color: Colors.blue.shade200,),
       )
    ],
  )
 ],),


          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,
           children:[ 
          
          SizedBox(
            
            child:    Row(children: taskWidgets,),
          ),
             
          
           Text('${data.varients![0]['price'].toString()} SAR ',style: const TextStyle(fontSize: 20,
           fontWeight: FontWeight.bold,color: Colors.grey), ),
           ]
            ),
        ],
      ),
    )
   )
  ],
        ),
      ),
  ),
  ); 
  }
}



