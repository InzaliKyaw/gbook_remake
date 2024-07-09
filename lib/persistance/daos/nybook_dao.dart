// import 'package:gbook_remake/data/vos/ny_book_list.dart';
// import 'package:gbook_remake/persistance/hive_constant.dart';
// import 'package:hive_flutter/adapters.dart';
//
// class NybookDao{
//   /// Must be Singleton
//   static final NybookDao _singleton = NybookDao._internal();
//
//   factory NybookDao(){
//     return _singleton;
//   }
//
//   NybookDao._internal();
//
//   Stream<void> watchBookBox(){
//     return getBookBox().watch();
//   }
//
//   List<NyBookList> getBookItemList(){
//     return getBookBox().values.toList();
//   }
//
//   Box<NyBookList> getBookBox(){
//     return Hive.box<NyBookList>(kBoxNameNyBookListVO);
//   }
// }