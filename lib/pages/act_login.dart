import 'package:fltr/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {




  @override
  Widget build(BuildContext context) {

 final controller = Get.put(CartController());
 

    return  Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
           // Text(controller.getUsername()),
               Container(
                padding: const EdgeInsets.only( bottom: 20),
                 child: const Column(
                  
                   children: [


                    
                      TextField(
                                   decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                                   ),
                                 ),
          SizedBox(height: 12,),
                                 TextField(
                                   decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                                   ),
                                 ),
                   ],
                 ),
               ),
          
          
              Center(child: 
                  
                  Hero(tag: "login_tag", child: ElevatedButton(
                                    style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(100, 20)),padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0,horizontal: 20))),
                                    onPressed: (){Navigator.pop(context);}, child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       
                                         Padding(
                                           padding: EdgeInsets.only( right:  5.0),
                                           child: Text("Login"),
                                         ),
                                          Icon(Icons.login,size: 15,),
                                      ],
                                    )))
              
              
              ),
            ],
          ),
        ),
      )
      
      )
    );
  }
}