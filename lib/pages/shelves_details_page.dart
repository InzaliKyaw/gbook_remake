import 'package:flutter/material.dart';
import 'package:gbook_remake/blocs/library_bloc.dart';
import 'package:gbook_remake/data/vos/book_shelve_vo.dart';
import 'package:gbook_remake/pages/edit_shelves_page.dart';
import 'package:gbook_remake/persistance/daos/shelves_dao.dart';
import 'package:provider/provider.dart';
import '../components/filter_dialog.dart';
import '../utils/dimes.dart';
import '../utils/strings.dart';

class ShelvesDetailsPage extends StatefulWidget {
  final String shelfId;
  const ShelvesDetailsPage({super.key, required this.shelfId});

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

  @override
  void initState() {
    super.initState();
    if(widget.shelfId != null){
      BookShelveVO? bookShelveVO =  _shelvesDao.getShelfById(widget.shelfId ?? "");
      setState(() {
        _shelfName = bookShelveVO?.shelveName ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          padding: EdgeInsets.only(left: 24.0,top: 24.0),
                          child: Text(_shelfName,
                            style: const TextStyle(
                                fontSize: 24
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0,bottom: 24.0),
                          child: RichText(
                            text: const TextSpan(
                                text: "0",
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "0",
                                      style: TextStyle(
                                          color: Colors.grey
                                      )
                                  ),
                                  TextSpan(
                                      text: " ",
                                      style: TextStyle(
                                          color: Colors.grey
                                      )
                                  ),
                                  TextSpan(
                                      text: kBook,
                                      style: TextStyle(
                                          color: Colors.grey
                                      )
                                  )
                                ]
                            ),
                          ),
                        ),
                        Divider()
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
              /*
              /// Book List Layout
              SliverVisibility(
                visible: isListView,
                sliver: SliverFillRemaining(
                  child: Selector<LibraryBloc, List<BookShelveVO>>(
                    selector: (context, bloc) => bloc.shelvesList,
                    builder: (context, libraryBookList, model) => ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: libraryBookList.length,
                        itemBuilder: (context, index) {
                          // String imageUrl = libraryBookList[index].bookImage ?? "";
                          // String bookTitle = libraryBookList[index].title ?? "";
                          // String bookAuthor = libraryBookList[index].author ?? "";
                          return Padding(
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
                                const Spacer(),
                                Image.asset(
                                  kDownloadImage,
                                  color: kPrimaryColor,
                                )
                              ],
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
                    builder: (context, libraryBookList, model) =>
                        Padding(
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
                              String imageUrl = libraryBookList[index].bookImage ?? "";
                              String bookTitle = libraryBookList[index].title ?? "";
                              String bookAuthor = libraryBookList[index].author ?? "";
                              int? weeksOnList = libraryBookList[index].weeksOnList;
                              return BookItemView(
                                imageUrl: imageUrl,
                                title: bookTitle,
                                author: bookAuthor,
                                weeksOnList: weeksOnList ?? 0,
                                imgWidth: gridViewWidth,
                                imgHeight: gridViewHeight,);
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
                              itemBuilder: (context,index){
                                String? shelveName = shelvesL[index].shelveName;
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => ShelvesDetailsPage()));
                                  },
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
                                            Text(shelveName?? "",
                                              style: const TextStyle(
                                                  fontSize: 20
                                              ),),
                                            /// Books Count
                                            RichText(
                                              text: const TextSpan(
                                                  text: "0",
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "0",
                                                        style: TextStyle(
                                                            color: Colors.grey
                                                        )
                                                    ),
                                                    TextSpan(
                                                        text: " ",
                                                        style: TextStyle(
                                                            color: Colors.grey
                                                        )
                                                    ),
                                                    TextSpan(
                                                        text: kBook,
                                                        style: TextStyle(
                                                            color: Colors.grey
                                                        )
                                                    )
                                                  ]
                                              ),
                                            ),
                                          ],

                                        ),),
                                      const Spacer(),
                                      const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Icon(Icons.chevron_right_sharp,
                                          size: 32,),
                                      )

                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: FloatingActionButton.extended(
                          backgroundColor:  Colors.blue,
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NewShelvesPage()));
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                          label: const Text('Create new',
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      )
                    ],

                  ),

                ),
              ),
               */
            ],
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
