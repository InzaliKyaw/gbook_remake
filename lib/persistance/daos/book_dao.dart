import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/persistance/hive_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookDao{
  /// Must be Singleton
  static final BookDao _singleton = BookDao._internal();

  factory BookDao(){
    return _singleton;
  }

  BookDao._internal();

  /*
    Only author, imageUrl, description and title is stored in Library
     */
  void saveBooks(Books books) async{
    /// Curly braces ka map
    Map<String, Books> bookMap = {books.title ?? "": books};
    await getBooksBox().putAll(bookMap);
  }

  List<Books> getAllBooksFromDB() {
   List<Books> bookList = getBooksBox().values.toList();
   return bookList;
  }

  Stream<void> watchBookBox(){
    return getBooksBox().watch();
  }

  Box<Books> getBooksBox(){
    return Hive.box<Books>(kBoxNameBookVO);
  }

}

