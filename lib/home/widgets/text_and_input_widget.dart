import 'package:assignment/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAndInputWidget extends StatelessWidget {
  final String title;
  final Function(String) onChanged;
  final TextEditingController controller;
  const TextAndInputWidget(
      {Key? key, required this.title, required this.onChanged, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.06,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: height * 0.01),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: st13pt500w(), /// used constant declared text style
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            height: 50,
            width: 60,
            alignment: Alignment.center,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }
}
