import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbook_remake/data/model/gbook_model.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/data/vos/ny_book_list.dart';
import 'package:gbook_remake/network/api_constants.dart';
import 'package:rxdart/subjects.dart';

import '../utils/strings.dart';

class HomeBloc extends ChangeNotifier{

  /// Model
  final GBookModel _model = GBookModel();

  List<NyBookList> getBookItemList = [];
  List<NyBookList> itemsToShow = [];
  List<Books> bookList = [];
  List<Books> searchResult = [];

  /// BookItem List
  StreamSubscription? _ebookSubscription;

  /// Ebooks or Audio
  String selectedText = kEbooksLabel;

  HomeBloc(){

    /// Ebooks from Library DB
    _ebookSubscription = _model.getBooksList().listen((booksFromDB){
      bookList = booksFromDB;
      print(bookList);
      notifyListeners();
    });

    /// Ebooks from Network
    _model.getNYBestSellerResponse(kAPIKey).then((nyBooksList) {
      if ( nyBooksList!= null) {
        getBookItemList = nyBooksList;
        itemsToShow = getBookItemList;
        notifyListeners();
      }
    });

  }

  void onSearchSubmit(String query){
    /// Search Books from Network
    _model.getGBooks(query).then((bookResultList){
      searchResult = bookResultList;
      notifyListeners();
        });
  }

  void onTapEbookorAudio(String text){
    /// Set Movies
    if (text == kEbooksLabel){
      itemsToShow = getBookItemList;
    }else{
      // moviesToShow = comingSoonMovies;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _ebookSubscription?.cancel();
    super.dispose();
  }

}