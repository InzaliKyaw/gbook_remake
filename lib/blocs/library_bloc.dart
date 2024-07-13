import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gbook_remake/data/model/gbook_model.dart';
import 'package:gbook_remake/data/vos/book_shelve_vo.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';

class LibraryBloc extends ChangeNotifier{
  /// Model
  final GBookModel _model = GBookModel();

  List<Books> libraryBookList = [];
  List<BookShelveVO> shelvesList = [];

  /// BookItem List
  StreamSubscription? _ebookSubscription;
  StreamSubscription? _shelvesSubscription;


  String shelveId = "";

  LibraryBloc(){
    /// Ebooks from Library DB
    /*
    Only author, imageUrl, description and title is stored in Library
     */
    _ebookSubscription = _model.getBooksList().listen((booksFromDB){
      libraryBookList = booksFromDB;
      print(libraryBookList);
      notifyListeners();
    });

    _shelvesSubscription = _model.getShelvesList().listen((shelvesFromDB){
      shelvesList = shelvesFromDB;
      notifyListeners();
    });

  }

  void updateShelfVOAddBook(String id, Books book){
    return _model.updateShelfVOAddBook(id, book);
  }

  void updateShelfVODeleteBook(String id, Books book){
    return _model.updateShelfVODeleteBook(id, book);
  }

  List<Books>? getCurrentBookShelf(String shelfId){
    return _model.getBookListByShelfId(shelfId);
  }

  @override
  void dispose() {
    _ebookSubscription?.cancel();
    _shelvesSubscription?.cancel();
    super.dispose();
  }
}