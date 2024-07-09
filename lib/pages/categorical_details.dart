import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/network/api_constants.dart';
import 'package:gbook_remake/pages/book_details.dart';
import '../data/model/gbook_model.dart';

class CategoricalDetails extends StatefulWidget {
  final String listName;
  const CategoricalDetails({super.key,required this.listName});

  @override
  State<CategoricalDetails> createState() => _CategoricalDetailsState();
}

class _CategoricalDetailsState extends State<CategoricalDetails> {
  final GBookModel _model = GBookModel();
  List<Books>? getBookItemListByCategory = [];


  @override
  void initState() {
    super.initState();
    
    _model.getNYBestSellerByCategory(kAPIKey, widget.listName).then((nyBookListByCategory){
      if(nyBookListByCategory!= null){
         setState(() {
           getBookItemListByCategory = nyBookListByCategory.bookList;
         });
      }
    }).catchError((error){
      showDialog(context: context, builder:
      (context) =>
      AlertDialog(
       content: Text(error.toString()),
    ));
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Padding(
               padding: EdgeInsets.symmetric(horizontal: 12),
               child: Row(
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                     },
                    child:  const Icon(
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
              Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 300), itemBuilder: (context,index){
                  Books? books = getBookItemListByCategory![index];
                  String imageUrl = books.bookImage ?? "";
                  String bookTitle = books.title ?? "";
                  String author = books.author ?? "";
                  String description = books.description ?? "";
                  int weekOnList = books.weeksOnList ?? 0;

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  BookDetails(title: bookTitle, author: author, description: description, bookImage: imageUrl,
                          weeksOnList: weekOnList,)));
                    },
                    child: SizedBox(
                      width: 168,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                height: 254,
                                width: 178,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 168,
                            child: Text(bookTitle,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            textAlign: TextAlign.left,),
                          ),

                        ],
                      ),
                    ),
                  );
                }, itemCount: getBookItemListByCategory?.length,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
