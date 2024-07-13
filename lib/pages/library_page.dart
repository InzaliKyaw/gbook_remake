import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbook_remake/blocs/library_bloc.dart';
import 'package:gbook_remake/components/book_item_view.dart';
import 'package:gbook_remake/components/shef_item_check_view.dart';
import 'package:gbook_remake/data/model/gbook_model.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/pages/TabButtonView.dart';
import 'package:gbook_remake/pages/edit_shelves_page.dart';
import 'package:gbook_remake/pages/search_book_page.dart';
import 'package:gbook_remake/pages/shelves_details_page.dart';
import 'package:gbook_remake/persistance/daos/shelves_dao.dart';
import 'package:gbook_remake/utils/colors.dart';
import 'package:gbook_remake/utils/dimes.dart';
import 'package:gbook_remake/utils/images.dart';
import 'package:gbook_remake/utils/strings.dart';
import 'package:provider/provider.dart';

import '../components/filter_dialog.dart';
import '../components/shelf_item_view.dart';
import '../data/vos/book_shelve_vo.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String selectedText = kYourBooks;
  bool isListView = true;
  bool isGridView = false;
  final GBookModel _model = GBookModel();
  double gridViewWidth = kSGridWidth;
  double gridViewHeight = kSGridHeight;
  int gridCount = 2;
  bool isSListShow = false;
  List<BookShelveVO> shelveList = [];

  // visible: selectedText == kYourBooks,
  @override
  void initState() {
    super.initState();
    setState(() {
      // shelveList = _shelvesDao.getAllShelves();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryBloc(),
      child: Scaffold(
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            /// Search Box
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SizedBox(
                    height: 40,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        => const SearchBookPage()));
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                            prefixIcon: const IconTheme(
                                data: IconThemeData(color: Colors.black),
                                child: Icon(Icons.search)),
                            focusColor: kPrimaryColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            suffixIcon: IconTheme(
                                data: const IconThemeData(color: Colors.black),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      kBookImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            hintText: kSearch,
                            hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                          ),
                          textAlign: TextAlign.start,
                          onSubmitted: (text){
                            // var bloc = context.read<HomeBloc>();
                            // bloc.onSearchSubmit(text);
                          },
                        ),
                      ),
                    ),

                  ),
                ),
              ),
            ),

            /// Tab Layout
            SliverToBoxAdapter(
              child: LibraryTabBar(
                  selectedText: selectedText,
                  onTapEbookorAudio: (text) {
                    setState(() {
                      selectedText = text;
                      if (text == kShelves) {
                        isListView = false;
                        isGridView = false;
                        isSListShow = true;
                      } else {
                        isSListShow = false;
                        isListView = true;
                      }
                    });
                  }),
            ),

            /// Fiter Buttons Section
            SliverVisibility(
              visible: selectedText == kYourBooks,
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FilterDialog(
                                labelOne: kRecent,
                                labelTwo: kTitle,
                                labelThree: kAuthor,
                                title: kSortBy,
                                onChooseFilter: (String) {
                                  // Sort the libraryBookList by author's name
                                  // libraryBookList.sort((a, b) => (a.author ?? '').compareTo(b.author ?? ''));
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.sort,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  kSorting,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                          child: const Icon(
                            Icons.grid_on_sharp,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FilterDialog(
                                  labelOne: kList,
                                  labelTwo: kLargeGrid,
                                  labelThree: kSmallGrid,
                                  title: kViewAs,
                                  onChooseFilter: (title) {
                                    // _setSelectedView(title);
                                    if (title == kList) {
                                      setState(() {
                                        isListView = true;
                                        isGridView = false;
                                      });
                                    } else if (title == kSmallGrid) {
                                      setState(() {
                                        isListView = false;
                                        isGridView = true;
                                        gridViewWidth = kSGridWidth;
                                        gridViewHeight = kSGridHeight;
                                        gridCount = 3;
                                      });
                                    } else {
                                      setState(() {
                                        isListView = false;
                                        isGridView = true;
                                        gridViewWidth = kLGridWidth;
                                        gridViewHeight = kLGridHeight;
                                        gridCount = 2;
                                      });
                                    }
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),

            /// Book List Layout
            SliverVisibility(
              visible: isListView,
              sliver: SliverFillRemaining(
                child: Selector<LibraryBloc, List<Books>>(
                  selector: (context, bloc) => bloc.libraryBookList,
                  builder: (context, libraryBookList, model) =>
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: libraryBookList.length,
                          itemBuilder: (context, index) {
                            String imageUrl =
                                libraryBookList[index].bookImage ?? "";
                            String bookTitle =
                                libraryBookList[index].title ?? "";
                            String bookAuthor =
                                libraryBookList[index].author ?? "";
                            return GestureDetector(
                              onLongPress: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                imageUrl,
                                                height: 80,
                                                width: 60,
                                              ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                child: ClipRect(
                                                  clipBehavior: Clip.none,
                                                  child: Text(
                                                    bookTitle,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          _buildSelectableTile(context,
                                              Icons.add, kAddToShelves, "", libraryBookList[index]),
                                          _buildSelectableTile(
                                              context,
                                              Icons.minimize,
                                              kDeleteFromShelves,
                                              "",
                                              libraryBookList[index]),
                                          _buildSelectableTile(
                                              context,
                                              Icons.delete,
                                              kDeleteFromLibrary,
                                              "",
                                              libraryBookList[index]),
                                          const Divider(),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: Image.network(
                                          imageUrl,
                                          height: 60,
                                          width: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bookTitle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: kTextRegular1x,
                                            ),
                                          ),
                                          Text(
                                            bookAuthor,
                                            style: const TextStyle(
                                              fontSize: kTextSmallx,
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Text(
                                                kDBookRating,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                                child: Icon(
                                                  Icons.star,
                                                  size: 12,
                                                ),
                                              ),
                                              Text(
                                                kDMoviePrice,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Image.asset(
                                        kDownloadImage,
                                        height: kSmallIconSize,
                                        width: kSmallIconSize,
                                        color: kPrimaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                ),
              ),
            ),

            SliverVisibility(
              visible: isGridView,
              sliver: SliverFillRemaining(
                child: Selector<LibraryBloc, List<Books>>(
                  selector: (context, bloc) => bloc.libraryBookList,
                  builder: (context, libraryBookList, model) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCount,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 280,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String imageUrl =
                            libraryBookList[index].bookImage ?? "";
                        String bookTitle = libraryBookList[index].title ?? "";
                        String bookAuthor = libraryBookList[index].author ?? "";
                        int? weeksOnList = libraryBookList[index].weeksOnList;
                        return BookItemView(
                          imageUrl: imageUrl,
                          title: bookTitle,
                          author: bookAuthor,
                          weeksOnList: weeksOnList ?? 0,
                          imgWidth: gridViewWidth,
                          imgHeight: gridViewHeight,
                        );
                      },
                      itemCount: libraryBookList.length,
                    ),
                  ),
                ),
              ),
            ),

            /// Shelves List
            SliverVisibility(
              visible: isSListShow,
              sliver: SliverFillRemaining(
                child: Column(
                  children: [
                    Expanded(
                      child: Selector<LibraryBloc, List<BookShelveVO>>(
                        selector: (context, bloc) => bloc.shelvesList,
                        builder: (context, shelvesL, model) => ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: shelvesL.length,
                            itemBuilder: (context, index) {
                              String? shelveName = shelvesL[index].shelveName;
                              String? shelfId = shelvesL[index].id;
                              int bookCount = shelvesL[index].bookCollectionList?.length ?? 0;
                              String? firstBookImg = null;
                              String? secondBookImg = null;
                              String bookLabel = kBook;
                              if(bookCount > 0){
                                firstBookImg = shelvesL[index].bookCollectionList?.first.bookImage ?? "";
                                if (bookCount > 1){
                                  secondBookImg = shelvesL[index].bookCollectionList![1].bookImage ?? "";
                                  bookLabel = kBooks;
                                }
                              }
                              return ShelfItemView(
                                  onTapShelve: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShelvesDetailsPage(shelfId: shelfId ?? "", bookLabel: bookLabel,)));
                                  },
                                  shelfId: shelfId,
                                  shelveName: shelveName,
                                  bookLabel: bookLabel,
                                  bookCount: bookCount.toString(),
                                firstBookImg: firstBookImg,
                                secondBookImg: secondBookImg,);
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditShelvesPage(
                                        shelfId: null,
                                      )));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                        label: const Text(
                          'Create new',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(Icons.edit,
                            color: Colors.white, size: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}


class LibraryTabBar extends StatelessWidget {
  final String selectedText;
  final Function(String) onTapEbookorAudio;

  const LibraryTabBar(
      {super.key, required this.selectedText, required this.onTapEbookorAudio});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTabBarHeight,
      margin: const EdgeInsets.symmetric(horizontal: kMarginSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          /// Your Books Button
          Expanded(
            child: TabButtonView(
              label: kYourBooks,
              isSelected: selectedText == kYourBooks,
              onTapButton: () {
                onTapEbookorAudio(kYourBooks);
              },
              fontSize: kTextSmall,
            ),
          ),

          /// Shelves Button
          Expanded(
            child: TabButtonView(
              label: kShelves,
              isSelected: selectedText == kShelves,
              onTapButton: () {
                onTapEbookorAudio(kShelves);
              },
              fontSize: kTextSmall,
            ),
          ),
        ],
      ),
    );
  }
}

/*
Book Add To Shleves by Id From Hive DB
Add To Shelves
=============
The Book count/Book should be added to BookList By checked and removed at unchecked

Remove From Shelves
=============
The Book count/Book should  removed at checked and not working at unchecked

 */

void _showFullScreenDialog(BuildContext context, Books book, String title) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    fullscreenDialog: true,
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (context) => LibraryBloc(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        kAddToShelves,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.close))
                    ],
                  ),
                     Expanded(
                      child: Selector<LibraryBloc, List<BookShelveVO>>(
                        selector: (context, bloc) => bloc.shelvesList,
                        builder: (context, shelvesL, model) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: shelvesL.length,
                              itemBuilder: (context, index) {
                                BookShelveVO? shelf = shelvesL[index];
                                String? shelveName = shelf.shelveName;
                                String? shelfId = shelf.id;
                                int bookCount = shelvesL[index].bookCollectionList?.length ?? 0;
                                String? firstBkImg = null;
                                String? secondBkImg = null;
                                String bookLabel = kBook;
                                List<Books> bookListFromDB = shelf.bookCollectionList ?? [];
                                firstBkImg = bookCount > 0 ? shelvesL[index].bookCollectionList?.first.bookImage : null;
                                String booksAmt = bookCount > 0 ?  shelf.bookCollectionList!.length.toString() : "0";
                                bool defaultCheck = false;
                                for(Books bookNameChk in bookListFromDB){
                                  if (bookNameChk.title == book.title){
                                    defaultCheck = true;
                                  }
                                }

                                if (bookCount > 1){
                                  secondBkImg = shelvesL[index].bookCollectionList![1].bookImage ?? "";
                                  bookLabel = kBooks;
                                }
                                // Extracting book names using map
                                // List<String?>? bookNames = shelf.bookCollectionList?.map((bookFromList) => bookFromList.title).toList();

                                // Checking if bookTitle exists in the list of book names
                                return ShelfItemCheckView(
                                    shelfId: shelfId,
                                    shelveName: shelveName,
                                  onTickCheck: (isChecked){
                                    var bloc = context.read<LibraryBloc>();
                                    if(title == kAddToShelves){
                                      if(isChecked){
                                        bloc.updateShelfVOAddBook(shelfId!, book);
                                      }else{
                                        bloc.updateShelfVODeleteBook(shelfId!, book);
                                        // booksAmt = bookCount > 0 ?  shelf.bookCollectionList!.length.toString() : "0";
                                      }
                                    }else{
                                      bloc.updateShelfVODeleteBook(shelfId!, book);
                                    }
                                    // shelvesL[index].bookCollectionList?.add(book);
                                }, isChecked: defaultCheck,
                                  bookCount: shelf.bookCollectionList?.length.toString(),
                                  firstBookImg: firstBkImg,
                                  secondBookImg: secondBkImg,
                                  bookLabel: bookLabel,);
                              }),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ));
}

Widget _buildSelectableTile(
    BuildContext context, IconData icon, String title, String selected, Books book) {
  return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (title == kDeleteFromLibrary) {
        } else{
          _showFullScreenDialog(context, book , title);
        }
      });
}

class CustomCornerShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6);

    const double shadowWidth = 10.0; // Adjust the width of the shadow as needed

    // Top shadow
    final pathTop = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - shadowWidth, shadowWidth)
      ..lineTo(shadowWidth, shadowWidth)
      ..close();

    // Left shadow
    final pathLeft = Path()
      ..moveTo(0, 0)
      ..lineTo(shadowWidth, shadowWidth)
      ..lineTo(shadowWidth, size.height - shadowWidth)
      ..lineTo(0, size.height)
      ..close();

    // Right shadow
    final pathRight = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width - shadowWidth, shadowWidth)
      ..lineTo(size.width - shadowWidth, size.height - shadowWidth)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(pathTop, paint);
    canvas.drawPath(pathLeft, paint);
    canvas.drawPath(pathRight, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
