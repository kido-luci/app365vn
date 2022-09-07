import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:laptt_app365vn/bindings/sign_in_page_binding.dart';
import 'package:laptt_app365vn/configs/path.dart';
import 'package:laptt_app365vn/views/guest/sign_in_page/sign_in_page.dart';

void main(List<String> args) => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App 365 VN',
      debugShowCheckedModeBanner: false,
      initialRoute: SIGN_IN_PAGE_ROUTE,
      getPages: [
        GetPage(
          name: SIGN_IN_PAGE_ROUTE,
          page: () => const SignInPage(),
          binding: SignInPageBinding(),
        )
      ],
    );
  }
}
