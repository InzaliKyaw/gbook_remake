import 'package:flutter/material.dart';
import 'package:gbook_remake/pages/library_page.dart';
import 'package:gbook_remake/utils/dimes.dart';
import 'package:gbook_remake/utils/images.dart';

import '../utils/strings.dart';

class ShelfItemView extends StatefulWidget {

  const ShelfItemView(
      {super.key,
        required this.shelfId,
        required this.shelveName,
        required this.onTapShelve,
        required this.bookCount,
        required this.firstBookImg,
        required this.secondBookImg,
        required this.bookLabel});

  final String? shelfId;
  final String? shelveName;
  final Function onTapShelve;
  final String? bookCount;
  final String? firstBookImg;
  final String? secondBookImg;
  final String bookLabel;


  @override
  State<ShelfItemView> createState() => _ShelfItemViewState();
}

class _ShelfItemViewState extends State<ShelfItemView> {
  @override
  Widget build(BuildContext context) {
    bool showPlaceholder = true;
    bool showFirstImage = false;
    bool showSecondImage = false;
    bool showSecondPlaceholder = true;

    if (widget.firstBookImg != null){
      showPlaceholder = false;
      showFirstImage = true;
    }
    if(widget.secondBookImg != null){
       showSecondPlaceholder = false;
       showSecondImage = true;
    }
    return GestureDetector(
      onTap: () {
        widget.onTapShelve();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  /// Second Image
                  Visibility(
                    visible: showSecondPlaceholder,
                     child: Positioned(
                      right: -4,
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
                              width: kShelfImageWidth,
                              height: 65,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showSecondImage,
                    child: Positioned(
                      right: -4,
                      child: Material(
                        color: Colors.transparent,
                        child: CustomPaint(
                          painter: CustomCornerShadowPainter(),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            child: Image.network(
                              widget.secondBookImg ?? "", // Replace with your image path
                              width: kShelfImageWidth,
                              height: 65,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// First Image
                  Visibility(
                    visible: showPlaceholder,
                    child: Padding(
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
                              width: kShelfImageWidth,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showFirstImage,
                    child: Padding(
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
                            child: Image.network(
                              widget.firstBookImg ?? "",
                              width: kShelfImageWidth,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
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
                    text:  TextSpan(text: "" , children: <TextSpan>[
                      TextSpan(text: widget.bookCount, style: const TextStyle(color: Colors.grey)),
                      const TextSpan(text: " ", style: TextStyle(color: Colors.grey)),
                      TextSpan(text: widget.bookLabel, style: const TextStyle(color: Colors.grey))
                    ]),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.chevron_right_sharp,
                size: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
