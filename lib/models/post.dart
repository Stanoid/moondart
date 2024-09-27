import 'package:flutter/widgets.dart';

class Post {
  
  int? id;
  String? name;
  String? subcat;
  String? seller;
  String? desc;
  List<String>? img;
  List<dynamic>? varients;
  int? price;
  Post({ this.id,this.desc,this.name,this.img,this.varients,this.subcat,this.seller});

  Post.fromJson(Map<String, dynamic> json) {
   subcat = json['subcatagory']['name_en'];
   desc = json['description_en'];
  id = json['id'];
  name = json['name_en'];
seller = json["seller"]["username"];
  
  try {

img = json['img'].replaceAll('[', '')
                  .replaceAll(']', '').replaceAll('"', '').split(',');

varients = json['varients'];

                 // log(varients![0].toString());


  } catch (e) {
    debugPrint(e.toString());
  }
  
  }

  
}
