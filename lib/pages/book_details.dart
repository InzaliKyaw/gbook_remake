import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gbook_remake/data/model/gbook_model.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/network/api_constants.dart';
import 'package:gbook_remake/persistance/daos/book_dao.dart';
import 'package:gbook_remake/utils/strings.dart';

class BookDetails extends StatefulWidget {
  final String author;
  final String title;
  final String description;
  final String bookImage;
  final int weeksOnList;


  const BookDetails(
      {super.key,
      required this.author,
      required this.title,
      required this.description,
      required this.bookImage,
      required this.weeksOnList});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}



class _BookDetailsState extends State<BookDetails> {
  final GBookModel _model = GBookModel();
  final BookDao _bookDao = BookDao();

  @override
  void initState() {
    super.initState();

    // _model.getNYBestSellerResponse(kAPIKey).then(())
    final newBook = Books(null, null, null, widget.author, widget.bookImage, null, null, null, null, null, null, widget.description, null, null, null, null, null, null, null, null, null, widget.title, null, widget.weeksOnList, null);
    _bookDao.saveBooks(newBook);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left_outlined,
                      size: 42,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.ios_share,
                    size: 24,
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      widget.bookImage,
                      width: 110,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          softWrap: true,
                          maxLines: null,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(widget.author,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal)),
                        ),
                        RichText(
                            text: const TextSpan(text: '', children: <TextSpan>[
                          TextSpan(
                              text: kBookType,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          TextSpan(
                            text: " . ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                              text: kBookPages,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                        ]))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),

            /// Buttons Session
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: const Text(
                      kReadSample,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Colors.blue),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.bookmark_border_sharp,
                              color: Colors.white,
                            ),
                            Text(
                              kAddToWishList,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),

            /// Text
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(
                      Icons.info_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      kBookDescription,
                      softWrap: true,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Text(
                    kAboutThisBook,
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Icon(
                    Icons.chevron_right,
                    size: 24,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                widget.description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
