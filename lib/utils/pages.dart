import 'package:get/get.dart';
import 'package:fltr/pages/home.dart';
import 'bindings/init_binding.dart';




part  'routes.dart';


class AppPages {
  AppPages._();
  
    static const INITIAL = Routes.INITIAL;
  static const HOME = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  


    static final routes = [
    GetPage(
      name: _Paths.INITIAL,
      page: () =>  const MyHomePage(title: "fltr",),
      binding: LaunchBinding(),
    ),
   
   
  ];
  
  
  }