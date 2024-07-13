import 'package:flutter/material.dart';
import 'package:gbook_remake/blocs/library_bloc.dart';
import 'package:gbook_remake/data/vos/book_shelve_vo.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/pages/edit_shelves_page.dart';
import 'package:gbook_remake/persistance/daos/shelves_dao.dart';
import 'package:provider/provider.dart';
import '../components/book_item_view.dart';
import '../components/filter_dialog.dart';
import '../utils/dimes.dart';
import '../utils/strings.dart';

class ShelvesDetailsPage extends StatefulWidget {
  final String shelfId;
  final String bookLabel;
  const ShelvesDetailsPage({
    super.key,
    required this.shelfId,
    required this.bookLabel});

  @override
  State<ShelvesDetailsPage> createState() => _ShelvesDetailsPageState();
}

class _ShelvesDetailsPageState extends State<ShelvesDetailsPage> {

  bool isListView = true;
  bool isGridView = false;
  bool isSListShow = false;
  double gridViewWidth = kSGridWidth;
  double gridViewHeight = kSGridHeight;
  int gridCount = 2;
  final ShelvesDao _shelvesDao = ShelvesDao();
  String _shelfName = "";
  String _bookCount = "0";
  BookShelveVO? bookShelveVO;
  List<Books>? bookList = [];
  int bookCollectionListSize =  0;


  @override
  void initState() {
    super.initState();
    if(widget.shelfId != null){
      bookShelveVO =  _shelvesDao.getShelfById(widget.shelfId ?? "");
      bookCollectionListSize = bookShelveVO?.bookCollectionList?.length ?? 0;
      if( bookCollectionListSize > 0){
        bookList = bookShelveVO?.bookCollectionList;
      }else{
        setState(() {
          isSListShow = false;
        });
      }

      setState(() {
        _shelfName = bookShelveVO?.shelveName ?? "";
        _bookCount = bookShelveVO?.bookCollectionList?.length.toString() ?? "0";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryBloc(),
      child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                /// App Bar Session
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.chevron_left_outlined,
                            size: 32,
                            color: Colors.blue,
                          ),
                        ),
                        const Text(kLibrary,
                        style: TextStyle(
                          color: Colors.blue
                        ),),
                        Spacer(),
                        /// Rename/Delete Button
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                       const ListTile(
                                        title: Text(
                                          kShelves,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Divider(),
                                      _buildSelectableTile(kRename, kRename),
                                      _buildSelectableTile(kDelete, ""),
                                      const Divider(),
                                    ],
                                  ),
                                );

                              },
                            );

                          },
                          child: const Icon(
                            Icons.more_horiz,
                            size: 32,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Shelve name and Book counts
                SliverToBoxAdapter(
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0,top: 24.0),
                            child: Text(_shelfName,
                              style: const TextStyle(
                                  fontSize: 24
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0,bottom: 24.0),
                            child: RichText(
                              text:  TextSpan(
                                  text: "",
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: _bookCount,
                                        style: const TextStyle(
                                            color: Colors.grey
                                        )
                                    ),
                                    const TextSpan(
                                        text: " ",
                                        style: TextStyle(
                                            color: Colors.grey
                                        )
                                    ),
                                    TextSpan(
                                        text:  widget.bookLabel,
                                        style: const TextStyle(
                                            color: Colors.grey
                                        )
                                    )
                                  ]
                              ),
                            ),
                          ),
                          const Divider()
                        ]
                  ),
                ),

                /// Fiter Buttons Section
                 SliverToBoxAdapter(
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
                                  onChooseFilter: (String ) {

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
                                    title:kViewAs,
                                    onChooseFilter: (title){
                                    // _setSelectedView(title);
                                    if(title == kList){
                                      setState(() {
                                        isListView = true;
                                        isGridView = false;
                                      });
                                    }else if(title == kSmallGrid){
                                      setState(() {
                                        isListView = false;
                                        isGridView = true;
                                        gridViewWidth = kSGridWidth;
                                        gridViewHeight = kSGridHeight;
                                        gridCount = 3;
                                      });
                                    }else{
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

                /// Book List Layout
                SliverVisibility(
                  visible: isListView,
                  sliver: SliverFillRemaining(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: bookCollectionListSize,
                        itemBuilder: (context, index) {
                          String imageUrl = bookList?[index].bookImage ?? "";
                          String bookTitle = bookList?[index].title ?? "";
                          String bookAuthor = bookList?[index].author ?? "";
                          return (bookCollectionListSize == 0) ?
                          Container()
                          :Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookTitle,
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
                                          padding: EdgeInsets.symmetric(horizontal: 2.0),
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
                              ],
                            ),
                          );
                        }),
                  ),
                ),

                /// Grid View
                SliverVisibility(
                  visible: isGridView,
                  sliver: SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCount,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 280,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                        String imageUrl = bookList?[index].bookImage ?? "";
                        String bookTitle = bookList?[index].title ?? "";
                        String bookAuthor = bookList?[index].author ?? "";
                        int? weeksOnList = bookList?[index].weeksOnList;
                          return BookItemView(
                            imageUrl: imageUrl,
                            title: bookTitle,
                            author: bookAuthor,
                            weeksOnList: weeksOnList ?? 0,
                            imgWidth: gridViewWidth,
                            imgHeight: gridViewHeight,);
                        },
                        itemCount: bookShelveVO?.bookCollectionList?.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildSelectableTile(String title, String selected) {
    return ListTile(
        title: Text(title),
        // tileColor: selected == title ? Colors.blue.shade100 : null,
        onTap: () {
          if(title == kRename){
            Navigator.push(context,
              MaterialPageRoute(builder:(context) => EditShelvesPage(shelfId: widget.shelfId,))
            );
          }else if(title == kDelete){
            _shelvesDao.deleteShelfById(widget.shelfId);
            Navigator.pop(context);
          }
        }
    );
  }
}
