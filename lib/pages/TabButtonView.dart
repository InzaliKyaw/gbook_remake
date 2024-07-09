import 'package:flutter/material.dart';
import 'package:gbook_remake/utils/colors.dart';
import 'package:gbook_remake/utils/dimes.dart';

class TabButtonView extends StatelessWidget {

  final bool isSelected;
  final String label;
  final double fontSize;
  final Function onTapButton;

  const TabButtonView({super.key,required this.isSelected, required this.label, required this.fontSize,required this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          onTapButton();
        },
        child: Container(
          margin: const EdgeInsets.all(kMarginMedium),
          decoration: BoxDecoration(
            // color: (isSelected)? kPrimaryColor: null,
              borderRadius: BorderRadius.circular(kMarginSmall),
              border: Border(
                bottom: BorderSide(width: 3.0,
                    color:  (isSelected)? kPrimaryColor: kBackgroundColor),
              )
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: (isSelected) ? kSelectedTextColor : kUnSelectedTextColor,
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        )
    );
  }
}
