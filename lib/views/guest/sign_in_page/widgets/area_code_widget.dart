import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptt_app365vn/configs/path.dart';
import 'package:laptt_app365vn/configs/theme.dart';
import 'package:laptt_app365vn/controllers/sign_in_page_controller.dart';
import 'package:laptt_app365vn/models/area_code_model/area_code_model.dart';
import 'package:laptt_app365vn/services/area_code_services.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class AreaCodeWidget extends GetView<SignInPageController> {
  const AreaCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double devicesWidth = MediaQuery.of(context).size.width;
    double devicesHeight = MediaQuery.of(context).size.height;

    return GetBuilder<SignInPageController>(
      builder: (_) {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          if (controller.isLoadMoreData) {
            List<AreaCodeModel> areaCodeModelList =
                await AreaCodeService.fetchAreaCodeList(
              soDongDaHienThi: controller.countLine,
              keyWork: controller.searchText,
            );
            print(areaCodeModelList.length);
            controller
              ..areaCodeModelList = [
                ...controller.areaCodeModelList,
                ...areaCodeModelList
              ]
              ..countLine += areaCodeModelList.length
              ..isLoadMoreData = false
              ..update();
            print(controller.areaCodeModelList.length);
          }
        });

        return SizedBox(
          height: devicesHeight,
          child: SlidingSheet(
            elevation: 5,
            cornerRadius: 16,
            maxWidth: devicesWidth / 100 * 90,
            snapSpec: const SnapSpec(
              initialSnap: 0,
              snappings: [0, 0.5, 1.0],
            ),
            controller: controller.sheetController,
            listener: (sheetState) {
              if (sheetState.extent == 1) {
                controller.isShowTopWidget.value = true;
              } else {
                controller.isShowTopWidget.value = false;
              }
              if (sheetState.isAtBottom &&
                  !controller.isLastPositionBottom &&
                  !controller.isLoadMoreData) {
                controller
                  ..isLoadMoreData = true
                  ..update();
              }
              controller.isLastPositionBottom = sheetState.isAtBottom;
            },
            builder: (context, state) {
              return SizedBox(
                height: controller.areaCodeModelList.length * 32 + 217 >
                        devicesHeight
                    ? controller.areaCodeModelList.length * 32 + 217
                    : devicesHeight,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      color: const Color.fromARGB(255, 231, 231, 231),
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
                            onTap: () =>
                                controller.sheetController.snapToExtent(0),
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
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 241, 241, 241),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
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
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: devicesWidth / 100 * 5),
                          child: Column(
                            children: controller.areaCodeModelList
                                .asMap()
                                .entries
                                .map((e) => getAreaCodeItemWidget(
                                    areaCodeModel: e.value))
                                .toList(),
                          ),
                        ),
                        Visibility(
                          visible: controller.isLoadMoreData,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget getAreaCodeItemWidget({required AreaCodeModel areaCodeModel}) =>
      InkWell(
        onTap: () {
          controller
            ..selectAreaCodeModel = areaCodeModel
            ..sheetController.snapToExtent(0)
            ..update();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      areaCodeModel.icon,
                      width: 12,
                      errorBuilder: (_, object, stackTrace) => Image.asset(
                        IMAGE_PATH + APPVN_PNG,
                        fit: BoxFit.cover,
                        width: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(areaCodeModel.phoneCode),
                  ],
                ),
                Text(areaCodeModel.areaName),
              ],
            ),
            Container(
              height: 0.5,
              color: Colors.black38,
              margin: const EdgeInsets.only(top: 7.5),
            )
          ],
        ),
      );
}
