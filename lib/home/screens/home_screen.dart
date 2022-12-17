import 'package:assignment/home/controllers/home_screen_controller.dart';
import 'package:assignment/home/widgets/checkbox_and_text_widget.dart';
import 'package:assignment/home/widgets/text_and_input_widget.dart';
import 'package:assignment/utils/custom_text_styles.dart';
import 'package:assignment/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController _homeScreenController =
      Get.put(HomeScreenController());

  @override
  void initState() {
    /// calling read json function defined in home screen controller
    _homeScreenController.readJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    ///SafeArea widget restrict content inside the device notch area
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: height * 0.01,
            ),
          ),
          child: Obx(() => SingleChildScrollView(child: _getBody(height))),
        ),
      ),
    );
  }

  /// this will return one widget which will be visible to user on mobile screen
  Widget _getBody(double height) {
    /// this condition will satisfy only when we got data
    if (_homeScreenController.widgetViewState.value ==
        ViewWidgetState.WIDGET_VIEW_STATE) {
      return Column(
        children: [
          /// total boxes each side input text field
          TextAndInputWidget(
            controller: _homeScreenController.totalBoxesController,
            title: _homeScreenController.jsonDataModel?.totalBoxInput ?? '',
            onChanged: (value) {
             _homeScreenController.setTotalBoxValue(value);
            },
          ),
          Container(
            color: Colors.black,
            height: height * 0.01,
            width: double.infinity,
          ),
          /// total selection allowed input text field
          TextAndInputWidget(
            controller: _homeScreenController.allowedSelectionController,
            title: _homeScreenController.jsonDataModel?.totalSelectionAllowed ??
                '',
            onChanged: (value) {
              _homeScreenController.setTotalAllowedSelection(value);
            },
          ),
          ///total alphabets selection allowed input text field
          TextAndInputWidget(
            controller: _homeScreenController.allowedAlpaSelectionController,
            title: _homeScreenController.jsonDataModel?.alphabetsAllowed ?? '',
            onChanged: (value) {
              _homeScreenController.setTotalAllowedAlphabet(value);
            },
          ),
          ///total numbers selection allowed input text field
          TextAndInputWidget(
            controller: _homeScreenController.allowedNumberSelectionController,
            title: _homeScreenController.jsonDataModel?.numbersAllowed ?? '',
            onChanged: (value) {
              _homeScreenController.setTotalAllowedNumbers(value);
            },
          ),
          Container(
            height: 2,
            margin: const EdgeInsets.only(top: 8),
            color: Colors.black,
          ),
          Obx(
            () => SizedBox(
              height: height * 0.55,
              child: _homeScreenController.boxesEachSide.value != 0 &&
                      // _homeScreenController.allowedNumberSelection.value != 0 &&
                      // _homeScreenController.allowedTotalSelection.value != 0 &&
                      // _homeScreenController.allowedAlphSelection.value != 0 &&
                      _homeScreenController.boxesEachSide.value <= 11
                  ? GetBuilder(
                      init: _homeScreenController,
                      builder: (controller) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///getting alphabet and checkbox view
                            CheckboxAndTextWidget(
                              isNumber: false,
                              checkboxLength:
                                  _homeScreenController.boxesEachSide.value,
                              list: _homeScreenController
                                      .jsonDataModel?.alphabetList ??
                                  [],
                            ),
                            Container(
                              width: 2,
                              color: Colors.black,
                            ),

                            ///getting numbers and checkbox view
                            CheckboxAndTextWidget(
                              checkboxLength:
                                  _homeScreenController.boxesEachSide.value,
                              list: _homeScreenController
                                      .jsonDataModel?.numberList ??
                                  [],
                            ),
                          ],
                        );
                      })
                  : Container(),
            ),
          ),
          Container(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: height * 0.128,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      _homeScreenController.resetAllToZero();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        border: Border(
                          right: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      child: Text(
                        _homeScreenController.jsonDataModel?.resetValue ?? '',
                        textAlign: TextAlign.center,
                        style: st13pt500w(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,

                      ///getting dynamic color according to msg
                      color: _homeScreenController.getErrorSuccessMsgBgClr(
                          _homeScreenController.errorMsg.value),

                      ///getting dynamic msg according to logic
                      child: Text(
                        _homeScreenController.errorMsg.value,
                        // _homeScreenController.getErrorSuccessMsg(),

                        style: st15ptBold(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );

      /// this condition will satisfy only before and while fetching data
    } else if (_homeScreenController.widgetViewState.value ==
        ViewWidgetState.WIDGET_LOADING_STATE) {
      return const Center(
        child: CircularProgressIndicator(),
      );

      /// this condition will satisfy when above both conditions not satisfy
    } else {
      return Center(
        child: Text(_homeScreenController.errorMsg.value),
      );
    }
  }
}
