import 'package:assignment/utils/enums.dart';
import 'package:get/get.dart';

class BaseGetxCotroller extends GetxController {

  ///common for all screens, used for manage screen states
  Rx<ViewWidgetState> widgetViewState = ViewWidgetState.WIDGET_LOADING_STATE.obs;

}