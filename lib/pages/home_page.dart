import 'package:flutter/material.dart';
import 'package:gbook_remake/blocs/home_bloc.dart';
import 'package:gbook_remake/data/model/gbook_model.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/data/vos/ny_book_list.dart';
import 'package:gbook_remake/network/api_constants.dart';
import 'package:gbook_remake/pages/TabButtonView.dart';
import 'package:gbook_remake/pages/categorical_details.dart';
import 'package:gbook_remake/pages/search_book_page.dart';
import 'package:gbook_remake/utils/colors.dart';
import 'package:gbook_remake/utils/dimes.dart';
import 'package:gbook_remake/utils/images.dart';
import 'package:gbook_remake/utils/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../persistance/daos/book_dao.dart';
import 'book_details.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String selectedText = kEbooksLabel;
  bool visibleBookList = true;
  final GBookModel _model = GBookModel();

  /// Now Playing Movies
  List<NyBookList> getBookItemList = [];
  late NyBookList? nybookList;
   List<Books> booksList = [];

   /// Books put into Library Session and get from Book table to display as Library
  List<Books> libraryBookList = [];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
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
                  /// Carousel Slides
                  SliverToBoxAdapter(
                    child: Selector<HomeBloc,List<Books>>(
                      selector: (context, bloc) => bloc.bookList,
                      builder: ( context,  bookList, child) {
                        if (bookList.isEmpty){
                            visibleBookList = false;
                        }else{
                            visibleBookList = true;
                        }
                        return Visibility(
                          visible: visibleBookList,
                          child: SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: ImageSliderDemo(bList: bookList)),
                        );
                      },
                    ),
                  ),
                  /// Tab Layout
                  SliverToBoxAdapter(
                    child: Selector<HomeBloc, String>(
                      selector: (context, bloc) => bloc.selectedText,
                      builder: (context, selectedText, child) => BooksTabBar(
                        selectedText: selectedText,
                        onTapEbookorAudio: (text){
                          var bloc = context.read<HomeBloc>();
                          bloc.onTapEbookorAudio(text);
                        },
                      ),

                    ),
                  ),
                  /// List Layout
                  Selector<HomeBloc, List<NyBookList>>(
                    selector: (context, bloc) => bloc.itemsToShow,
                    builder: (context, itemsToShow, model){
                        return (itemsToShow.isEmpty) ?
                        const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          ),
                        ): SliverList(delegate: SliverChildBuilderDelegate((context,index){
                        nybookList = itemsToShow[index];
                        String? categoryName = nybookList?.displayName;
                        booksList  = nybookList?.books ?? [];
                        String listName = nybookList?.listName ?? "";
                        return Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                  child: GestureDetector(
                                    onTap:(){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CategoricalDetails(listName: listName,)));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                                          child: Text( categoryName!,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),),
                                        ),
                                        const Icon(
                                          Icons.arrow_right_alt,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 280,
                                  /// Book List
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: booksList.length,
                                      itemBuilder: (context,index){
                                        Books books = booksList[index];
                                        String? imageUrl = books.bookImage;
                                        String? title = books.title;
                                        String? author = books.author;
                                        String? description = books.description;
                                        int weeksOnList = books.weeksOnList ?? 0;
                                        return Padding(
                                          padding:  const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) =>  BookDetails(
                                                    title: title ?? "", author: author ?? "", description: description ?? "", bookImage: imageUrl, weeksOnList: weeksOnList,
                                                  )));                                          },
                                            child: SizedBox(
                                              width: 128,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network(
                                                        imageUrl!,
                                                        height: 200,
                                                        width: 138,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: Text(books.title!,
                                                      overflow: TextOverflow.clip,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),),
                                                  ),
                                                  // const Text(kDMovieIssue,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //   ),),
                                                  Row(
                                                    children: [
                                                      Text(books.rank.toString(),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),),
                                                      const Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                        child: Icon(Icons.star,
                                                          size: 12,),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                          childCount: itemsToShow.length));
                    },
                  ),
                ],
              )
          ),
      ),
    );
  }
}

class ImageSliderDemo extends StatefulWidget {
  final List<Books> bList;

  const ImageSliderDemo({super.key, required this.bList});

  @override
  State<ImageSliderDemo> createState() => _ImageSliderDemoState();
}

class _ImageSliderDemoState extends State<ImageSliderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1/1,
              autoPlay: false ,
              initialPage: 1,
              enlargeCenterPage: true,
              viewportFraction: 0.35
            ),
            items: widget.bList
          .map((item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: 138,
                height: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        height: 180,
                        item.bookImage ?? "",
                        width: 128,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(item.title ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                        ),),
                    ),
                     Row(
                      children: [
                        Text( item.weeksOnList.toString()  ,
                          style: const TextStyle(
                            fontSize: 12,
                          ),),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(Icons.tag_rounded,
                            size: 12,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )

            ).toList(),
          )),
    );
  }
}

class BooksTabBar extends StatelessWidget {

  final String selectedText;
  final Function(String) onTapEbookorAudio;

  const BooksTabBar({super.key, required this.selectedText, required this.onTapEbookorAudio}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTabBarHeight,
      margin: const EdgeInsets.symmetric(horizontal: kMarginLarge),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          /// Ebooks Button
          Expanded(child: TabButtonView(
            label: kEbooksLabel,
            isSelected: selectedText == kEbooksLabel,
            onTapButton: (){
              onTapEbookorAudio(kEbooksLabel);
            }, fontSize: kTextRegular2x,
          ),
          ),

          /// Audiobooks Button
          Expanded(child: TabButtonView(
            label: kAudioBooksLabel,
            isSelected: selectedText == kAudioBooksLabel,
            onTapButton: (){
              onTapEbookorAudio(kAudioBooksLabel);
            }, fontSize: kTextRegular2x,
          ),
          )
        ],
      ),
    );
  }

}

