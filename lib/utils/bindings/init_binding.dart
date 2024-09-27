import 'package:get/get.dart';
import 'package:fltr/utils/controllers/init_controller.dart';

class LaunchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaunchController>(
          () => LaunchController(),
    );
  }
}