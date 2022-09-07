import 'package:get/get.dart';
import 'package:laptt_app365vn/controllers/sign_in_page_controller.dart';

class SignInPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInPageController());
  }
}
