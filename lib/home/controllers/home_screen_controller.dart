import 'package:assignment/getx/base_getx_controller.dart';
import 'package:assignment/home/models/data_model.dart';
import 'package:assignment/utils/constants.dart';
import 'package:assignment/utils/enums.dart';
import 'package:assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomeScreenController extends BaseGetxCotroller {
  TextEditingController totalBoxesController = TextEditingController();
  TextEditingController allowedSelectionController = TextEditingController();
  TextEditingController allowedAlpaSelectionController =
      TextEditingController();
  TextEditingController allowedNumberSelectionController =
      TextEditingController();

  /// for store all json data into class object
  RxString errorMsg = ''.obs;

  /// for store error msg and to show on UI
  DataModel? jsonDataModel;

  /// for store total boxes input
  RxInt boxesEachSide = 0.obs;

  /// for store total all boxes selection allowed input
  RxInt allowedTotalSelection = 0.obs;

  /// for alphabet selection allowed input
  RxInt allowedAlphSelection = 0.obs;

  /// for number selection allowed input
  RxInt allowedNumberSelection = 0.obs;

  ///for store total selection count of alphabet
  RxInt totalSelectedAlphabet = 0.obs;

  ///for store total selection count of number
  RxInt totalSelectedNumber = 0.obs;

  Future<void> readJsonData() async {
    try {
      Map<String, dynamic> data = await loadJsonFile(jsonDataFile);

      /// reading data from json file
      jsonDataModel = DataModel.fromMap(data);

      ///converting json map to class object
      widgetViewState.value = ViewWidgetState.WIDGET_VIEW_STATE;
    } catch (e) {
      errorMsg.value = e.toString();
      widgetViewState.value = ViewWidgetState.WIDGET_ERROR_STATE;
    }
  }

  ///for get dynamic msg according to logic
  void getErrorSuccessMsg() {
    String msg = '';
    if (boxesEachSide.value > 11) {
      msg = getFormattedStringForDouble(
          jsonDataModel?.inputCheckboxLimitError ?? '', '11', '11');
    } else if ((boxesEachSide * 2) < allowedTotalSelection.value) {
      msg = getFormattedString(jsonDataModel?.inputSelectionLimitError ?? '',
          (boxesEachSide * 2).toString());
    } else if (allowedAlphSelection.value > boxesEachSide.value) {
      msg = getFormattedString(jsonDataModel?.inputAlphabetsLimitError ?? '',
          '${boxesEachSide.value}');
    } else if (allowedNumberSelection.value > boxesEachSide.value) {
      msg = getFormattedString(jsonDataModel?.inputNumbersLimitError ?? '',
          '${boxesEachSide.value}');
    } else if (allowedTotalSelection.value <
        (totalSelectedAlphabet.value + totalSelectedNumber.value)) {
      msg = getFormattedString(jsonDataModel?.maxSelectionReachedError ?? '',
          allowedTotalSelection.value.toString());
    } else if (allowedAlphSelection.value < totalSelectedAlphabet.value) {
      msg = getFormattedString(jsonDataModel?.maxAlphabetReachedError ?? '',
          allowedAlphSelection.value.toString());
    } else if (allowedNumberSelection.value < totalSelectedNumber.value) {
      msg = getFormattedString(jsonDataModel?.maxNumbersReachedError ?? '',
          allowedNumberSelection.value.toString());
    } else {
      msg = jsonDataModel?.success ?? '';
    }
    errorMsg.value = msg;
    // return msg;
  }

  ///for get dynamic error msg bg color
  Color getErrorSuccessMsgBgClr(String msg) {
    Color color = Colors.greenAccent;
    if (msg.isNotEmpty && msg != jsonDataModel?.success) {
      color = Colors.redAccent;
    }
    return color;
  }

  ///for rest all values to zero
  void resetAllToZero() {
    allowedNumberSelectionController.clear();
    allowedAlpaSelectionController.clear();
    allowedSelectionController.clear();
    totalBoxesController.clear();
    boxesEachSide.value = 0;
    totalSelectedNumber.value = 0;
    totalSelectedAlphabet.value = 0;
    allowedAlphSelection.value = 0;
    allowedNumberSelection.value = 0;
    allowedTotalSelection.value = 0;
    resetLists();
  }

  ///for number checkbox selection
  void selectNumberCheckBox(int index, bool isSelected) {
    if (isSelected) {
      totalSelectedNumber.value += 1;
    } else {
      totalSelectedNumber.value -= 1;
    }
    getErrorSuccessMsg();
    if(allowedTotalSelection.value < (totalSelectedNumber.value + totalSelectedAlphabet.value) || totalSelectedNumber.value > allowedNumberSelection.value) {
      totalSelectedNumber.value -= 1;
    }else{
      jsonDataModel?.numberList[index].isSelected = isSelected;
      update();
    }
  }

  ///for alphabet checkbox selection
  void selectAlphabetCheckBox(int index, bool isSelected) {
    if (isSelected) {
      totalSelectedAlphabet.value += 1;
    } else {
      totalSelectedAlphabet.value -= 1;
    }
    getErrorSuccessMsg();
    if (allowedTotalSelection.value < (totalSelectedNumber.value + totalSelectedAlphabet.value) || totalSelectedAlphabet.value > allowedAlphSelection.value) {
      totalSelectedAlphabet.value -= 1;
    } else {
      jsonDataModel?.alphabetList[index].isSelected = isSelected;
      update();
    }
  }

  ///reset all check box to unselected
  void resetLists() {
    for (var e in jsonDataModel?.alphabetList ?? []) {
      e.isSelected = false;
    }
    for (var e in jsonDataModel?.numberList ?? []) {
      e.isSelected = false;
    }
  }

  ///for set user input total boxes each side
  void setTotalBoxValue(String value) {
    if (value.isNotEmpty) {
      boxesEachSide.value = int.parse(value);
    } else {
      resetAllToZero();
      boxesEachSide.value = 0;
    }
    getErrorSuccessMsg();
  }

  ///for set user input total selection
  void setTotalAllowedSelection(value) {
    if (value.isNotEmpty) {
      allowedTotalSelection.value = int.parse(value);
    } else {
      allowedTotalSelection.value = 0;
    }
    getErrorSuccessMsg();
  }

  ///for set user input allowed numbers
  void setTotalAllowedNumbers(String value) {
    if (value.isNotEmpty) {
      allowedNumberSelection.value = int.parse(value);
    } else {
      allowedNumberSelection.value = 0;
    }
    getErrorSuccessMsg();
  }

  ///for set user input allowed alphabet
  void setTotalAllowedAlphabet(String value) {
    if (value.isNotEmpty) {
      allowedAlphSelection.value = int.parse(value);
    } else {
      allowedAlphSelection.value = 0;
    }
    getErrorSuccessMsg();
  }
}
