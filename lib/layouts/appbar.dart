import 'package:flutter/material.dart';

class AppBarG extends StatefulWidget {
  const AppBarG({super.key});

  @override
  State<AppBarG> createState() => _AppBarGState();
}

class _AppBarGState extends State<AppBarG> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              tooltip: 'Open shopping cart',
              onPressed: () {
                // handle the press
              },
            ),
          ],
          title:  Padding(
              padding: const EdgeInsets.all(0),
              child: Row(children: [
                SizedBox(
                  width: 30.0,
                  child: Image.network('http://192.168.70.110:1337/uploads/amblemwhite_4436753f99.png',cacheWidth: 80, width: 30,)
                      
                ),
                const SizedBox(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Minimoon",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ))))
              ])));
  }
}