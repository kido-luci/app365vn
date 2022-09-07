import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptt_app365vn/configs/path.dart';
import 'package:laptt_app365vn/configs/theme.dart';
import 'package:laptt_app365vn/controllers/sign_in_page_controller.dart';
import 'package:laptt_app365vn/models/area_code_model/area_code_model.dart';
import 'package:laptt_app365vn/services/area_code_services.dart';
import 'package:laptt_app365vn/views/guest/sign_in_page/widgets/area_code_widget.dart';

class SignInPage extends GetView<SignInPageController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double devicesHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        controller.isFocus.value = false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder<SignInPageController>(builder: (_) {
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              if (controller.isInitData.value) {
                print(2);
                List<AreaCodeModel> areaCodeModelList =
                    await AreaCodeService.fetchAreaCodeList(
                        soDongDaHienThi: controller.countLine);
                controller
                  ..areaCodeModelList = areaCodeModelList
                  ..countLine = areaCodeModelList.length
                  ..selectAreaCodeModel = areaCodeModelList[0]
                  ..isInitData.value = false;
              }
            });

            return Obx(
              () => controller.isInitData.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth / 100 * 10),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: devicesHeight / 100 * 7),
                                    child: Image.asset(
                                      IMAGE_PATH + APPVN_PNG,
                                      height: devicesHeight / 100 * 9,
                                    ),
                                  ),
                                  Text(
                                    'Xin chào!',
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: devicesHeight / 100 * 3),
                                    child: Text(
                                      'Vui lòng nhập số điện thoại của bạn để quản lý Giao dịch Bất động sản hiệu quả hơn!',
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  getPhoneNumberTestField(),
                                ],
                              ),
                              const Spacer(),
                              getBottomButton(deviceHeight: devicesHeight),
                            ],
                          ),
                        ),
                        const AreaCodeWidget(),
                        Visibility(
                          visible: controller.isShowTopWidget.value,
                          child: topPopupWidget(deviceWidth: deviceWidth),
                        ),
                      ],
                    ),
            );
          }),
        ),
      ),
    );
  }

  Widget topPopupWidget({required double deviceWidth}) => Column(
        children: [
          Container(
            height: 40,
            width: deviceWidth / 100 * 90,
            margin: EdgeInsets.symmetric(horizontal: deviceWidth / 100 * 5),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 231, 231, 231),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Text(
                    'Mã vùng',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(fontSize: 17),
                  ),
                ),
                InkWell(
                  onTap: () => controller.sheetController.snapToExtent(0),
                  child: const SizedBox(
                    width: 50,
                    child: Center(child: Icon(Icons.close)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: (deviceWidth / 100 * 5)),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 241, 241, 241),
            ),
            margin:
                EdgeInsets.symmetric(horizontal: 10 + (deviceWidth / 100 * 5)),
            child: Row(
              children: [
                InkWell(
                  onTap: () => controller
                    ..areaCodeModelList = []
                    ..countLine = 0
                    ..isLoadMoreData = true
                    ..update(),
                  child: const SizedBox(
                    width: 50,
                    child: Center(child: Icon(Icons.search)),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller.textEditingController,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                    cursorColor: PRIMARY_COLOR,
                    // onTap: () {

                    // },
                    onChanged: (value) {
                      controller.searchText = value;
                    },
                    onSubmitted: (_) {
                      controller
                        ..areaCodeModelList = []
                        ..countLine = 0
                        ..isLoadMoreData = true
                        ..update();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Tìm kiếm',
                      isCollapsed: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );

  Widget getBottomButton({required double deviceHeight}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: deviceHeight / 100 * 4),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: controller.isEnableButtonNext.value
                ? PRIMARY_COLOR
                : Colors.black12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.next_plan_outlined,
                color: controller.isEnableButtonNext.value
                    ? Colors.white
                    : Colors.black.withOpacity(0.3),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Tiếp tục',
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: controller.isEnableButtonNext.value
                      ? Colors.white
                      : Colors.black.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPhoneNumberTestField() {
    return Obx(
      () => Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.isFocus.value
                          ? PRIMARY_COLOR
                          : Colors.black45,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 40,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () =>
                            controller.sheetController.snapToExtent(0.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 3, bottom: 1),
                              child: Image.network(
                                controller.selectAreaCodeModel.icon,
                                width: 15,
                              ),
                            ),
                            Text(
                              controller.selectAreaCodeModel.phoneCode,
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black45,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: !controller.isFocus.value &&
                            controller.phoneNumber.value.isEmpty,
                        child: Row(
                          children: [
                            Text(
                              'Số điện thoại',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.black45,
                              ),
                            ),
                            Text(
                              '*',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.only(left: 16, top: 5),
                child: Visibility(
                  visible: controller.isFocus.value,
                  child: Text(
                    'Tối đa 300 ký tự',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 95, right: 10),
            child: TextField(
              autofocus: true,
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: Colors.black87,
              ),
              cursorColor: PRIMARY_COLOR,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(
                    r'[0-9]',
                  ),
                ),
              ],
              onTap: () {
                controller.isFocus.value = true;
              },
              onChanged: (value) {
                controller.phoneNumber.value = value;
                if (value.length == 10 && value[0] == '0') {
                  controller.isEnableButtonNext.value = true;
                } else if (value.length == 9 && value[0] != '0') {
                  controller.isEnableButtonNext.value = true;
                } else {
                  controller.isEnableButtonNext.value = false;
                }
              },
              onSubmitted: (_) {
                controller.isFocus.value = false;
              },
              // onEditingComplete: () {
              //   print('4');
              // },
              decoration: const InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
              ),
            ),
          ),
          Visibility(
            visible: controller.isFocus.value ||
                controller.phoneNumber.value.isNotEmpty,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(left: 10, top: 2),
              width: 90,
              child: Row(
                children: [
                  Text(
                    '  Số điện thoại ',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
