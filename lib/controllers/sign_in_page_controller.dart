import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laptt_app365vn/models/area_code_model/area_code_model.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class SignInPageController extends GetxController {
  RxBool isFocus = true.obs;
  RxString phoneNumber = ''.obs;
  RxString areaCode = ''.obs;
  RxBool isEnableButtonNext = false.obs;
  SheetController sheetController = SheetController();
  RxBool isInitData = true.obs;
  bool isLoadMoreData = false;
  late List<AreaCodeModel> areaCodeModelList;
  int countLine = 0;
  late AreaCodeModel selectAreaCodeModel;
  bool isLastPositionBottom = false;
  String searchText = '';
  RxBool isShowTopWidget = false.obs;
  TextEditingController textEditingController = TextEditingController();
}
