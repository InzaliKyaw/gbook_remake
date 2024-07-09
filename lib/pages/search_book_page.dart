import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbook_remake/blocs/home_bloc.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/utils/colors.dart';
import 'package:gbook_remake/utils/strings.dart';
import 'package:provider/provider.dart';

import '../utils/dimes.dart';

class SearchBookPage extends StatefulWidget {
  const SearchBookPage({super.key});

  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  bool isSearchResultVisible = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => HomeBloc(),
        child:Scaffold(
          body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.chevron_left,
                            size: 24,),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 340,
                        child: Selector<HomeBloc, String>(
                          selector: (context, bloc) => bloc.selectedText,
                          builder: (context, value, child) => TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                              focusColor: kPrimaryColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              hintText: kSearch,
                              hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                            ),
                            textAlign: TextAlign.start,
                            onSubmitted: (text){
                              var bloc = context.read<HomeBloc>();
                              bloc.onSearchSubmit(text);
                              setState(() {
                                isSearchResultVisible = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverVisibility(
                visible: isSearchResultVisible,
                sliver: SliverFillRemaining(
                  child: Selector<HomeBloc, List<Books>>(
                    selector: (context, bloc) => bloc.searchResult,
                    builder: (context, searchBookResult, model){
                      return (searchBookResult.isEmpty) ?
                      const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ):ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: searchBookResult.length,
                          itemBuilder: (context,index){
                        String? author = searchBookResult[index]?.author;
                        String? title = searchBookResult[index]?.title ?? "";
                        String? imgUrl = searchBookResult[index]?.bookImage ?? "";
                        return Padding(
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
                                    imgUrl,
                                    height: 100,
                                    width: 80,
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
                                      title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: kTextRegular1x,
                                      ),
                                    ),
                                    Text(
                                      author!,
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
                            ],
                          ),
                        );
                      });
                    }
                ),
              ),
              )
            ],
          ),
        ),
    )
    );
  }
}

