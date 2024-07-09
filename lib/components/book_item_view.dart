import 'package:flutter/material.dart';

class BookItemView extends StatefulWidget{
  final String imageUrl;
  final String title;
  final String author;
  final int weeksOnList;
  final double imgWidth;
  final double imgHeight;


  const BookItemView({super.key,required this.imageUrl,required this.title,required this.author, required this.weeksOnList, required this.imgWidth, required this.imgHeight,});

  @override
  _BookItemViewState createState() => _BookItemViewState();
}

class _BookItemViewState extends State<BookItemView>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: (){
               },
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
                    widget.imageUrl,
                    height: widget.imgHeight,
                    width: widget.imgWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 200,
                child: Text(widget.title,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 10,
                  ),),
              ),
              Text(widget.author,
                style: const TextStyle(
                  fontSize: 12,
                ),),
              Row(
                children: [
                  Text(widget.weeksOnList.toString(),
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
  }

}