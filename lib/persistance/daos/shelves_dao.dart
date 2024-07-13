import 'dart:ffi';

import 'package:gbook_remake/data/vos/book_shelve_vo.dart';
import 'package:gbook_remake/persistance/hive_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../data/vos/book_vo.dart';

class ShelvesDao{

  static final ShelvesDao _singleton = ShelvesDao._internal();
  factory ShelvesDao(){
    return _singleton;
  }

  ShelvesDao._internal();

  void createShelf(String shelfName) async{
    /// Curly braces ka map
    var uuid = Uuid();
    var v1Uuid = uuid.v1();
    var bookShelvesVO1 = BookShelveVO(id: v1Uuid, shelveName: shelfName, bookCollectionList:  null);
    Map<String, BookShelveVO> shelveMap = { v1Uuid : bookShelvesVO1};
    await getShelfBox().putAll(shelveMap);
  }

  List<BookShelveVO> getAllShelves(){
    List<BookShelveVO> shelvesList = getShelfBox().values.toList();
    return shelvesList;
  }

  BookShelveVO? getShelfById(String id){
    return getShelfBox().get(id);
  }

  void updateShelfNameById(String id, String name){
   getShelfBox().get(id)?.shelveName = name;
  }

  List<Books>? getBookListByShelfId(String shelfId){
    return getShelfBox().get(shelfId)?.bookCollectionList;
  }

  void updateShelfByAddingBook(String id,Books book) {
    final shelf = getShelfBox().get(id);
    // Get the current book collection list
    // List<Books> bookList = shelf?.bookCollectionList ?? [];
    if(shelf?.bookCollectionList == null){
      shelf?.bookCollectionList = [];
      shelf?.bookCollectionList?.add(book);
    }else{
      shelf?.bookCollectionList?.add(book);
    }
    ///getShelfBox().get(id)?.bookCollectionList = bookList;
    // print(getShelfBox().get(id));
    getShelfBox().put(shelf?.id, shelf!);
    // BookShelveVO? bShelfCurrent = getShelfBox().get(id);
    // print(bShelfCurrent);
  }

  void updateShelfByRemovingBook(String id,Books book) {
    final shelf = getShelfBox().get(id);
    if(shelf?.bookCollectionList != null){
      shelf?.bookCollectionList?.remove(book);
    }
    getShelfBox().put(shelf?.id, shelf!);
  }


    void deleteShelfById(String id){
    getShelfBox().delete(id);
  }
  
  Stream<void> watchShelfBox(){
    return getShelfBox().watch();
  }

  Box<BookShelveVO> getShelfBox(){
    return Hive.box<BookShelveVO>(kBoxNameShelfVO);
  }
}