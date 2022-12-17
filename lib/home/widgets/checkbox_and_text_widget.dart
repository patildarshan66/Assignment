import 'package:assignment/home/controllers/home_screen_controller.dart';
import 'package:assignment/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckboxAndTextWidget extends StatelessWidget {
  final List<dynamic> list;
  final int checkboxLength;
  final bool isNumber;
  CheckboxAndTextWidget({
    Key? key,
    required this.list,
    required this.checkboxLength,
    this.isNumber = true,
  }) : super(key: key);

  final HomeScreenController _homeScreenController = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(
            checkboxLength,
            (index) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Checkbox(
                      checkColor: Colors.blue,
                      // activeColor: Colors.blue,
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(width: 1.0, color: Colors.blue),
                      ),
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return Colors.white;
                      }),
                      value: list[index].isSelected,
                      onChanged: (value) {
                        if (isNumber) {
                          _homeScreenController.selectNumberCheckBox(index, value ?? false);
                        } else {
                          _homeScreenController.selectAlphabetCheckBox(index, value ?? false);
                        }
                      }),
                ),
                Text(
                  '${list[index].title}',
                  style: st15ptBold(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
