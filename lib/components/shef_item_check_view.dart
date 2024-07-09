import 'package:flutter/material.dart';
import 'package:gbook_remake/pages/library_page.dart';
import 'package:gbook_remake/utils/images.dart';

import '../utils/strings.dart';

class ShelfItemCheckView extends StatefulWidget {

  const ShelfItemCheckView(
      {super.key,
        required this.shelfId,
        required this.shelveName,
        required this.onTickCheck});

  final String? shelfId;
  final String? shelveName;
  final Function onTickCheck;

  @override
  State<ShelfItemCheckView> createState() => _ShelfItemCheckViewState();
}

class _ShelfItemCheckViewState extends State<ShelfItemCheckView> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -8,
                child: Material(
                  color: Colors.transparent,
                  child: CustomPaint(
                    painter: CustomCornerShadowPainter(),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      child: Image.asset(
                        kImageShelve, // Replace with your image path
                        width: 80,
                        height: 65,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Material(
                  color: Colors.transparent, // Adjust elevation as needed
                  child: CustomPaint(
                    painter: CustomCornerShadowPainter(),
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(5.0),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      child: Image.asset(
                        kImageShelve,
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.shelveName ?? "",
                style: const TextStyle(fontSize: 20),
              ),

              /// Books Count
              RichText(
                text: const TextSpan(text: "0", children: <TextSpan>[
                  TextSpan(text: "0", style: TextStyle(color: Colors.grey)),
                  TextSpan(text: " ", style: TextStyle(color: Colors.grey)),
                  TextSpan(text: kBook, style: TextStyle(color: Colors.grey))
                ]),
              ),
            ],
          ),
        ),
        const Spacer(),
         Padding(
          padding: const EdgeInsets.all(12.0),
          child: Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
              widget.onTickCheck(_isChecked);
            },
          ),
        )
      ],
    );
  }
}
